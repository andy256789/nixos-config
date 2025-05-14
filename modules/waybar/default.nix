{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.waybar;
    theme = config.themes;
in {
    options.modules.waybar = {
        enable = mkEnableOption "Enable waybar";
    };

    config = mkIf cfg.enable {
        programs.waybar = {
            enable = true;
            settings = {
                mainBar = {
                    layer = "top";
                    position = "top";
                    height = 30;
                    spacing = 5;
                    margin-top = 5;
                    margin-bottom = 0;
                    margin-left = 5;
                    margin-right = 5;
                    modules-left = [
                        "hyprland/workspaces"
                        "hyprland/window"
                    ];
                    modules-center = [
                        "clock"
                    ];
                    modules-right = [
                        "pulseaudio"
                        "network"
                        "cpu"
                        "memory"
                        "backlight"
                        "battery"
                        "tray"
                    ];

                    "hyprland/workspaces" = {
                        format = "{name}";
                        sort-by-number = true;
                        on-click = "activate";
                        on-scroll-up = "hyprctl dispatch workspace e+1";
                        on-scroll-down = "hyprctl dispatch workspace e-1";
                        all-outputs = true;
                        active-only = false;
                        show-special = false;
                    };

                    "hyprland/window" = {
                        format = "{}";
                        max-length = 50;
                        separate-outputs = true;
                    };

                    "clock" = {
                        format = "{:%H:%M}";
                        format-alt = "{:%Y-%m-%d %H:%M}";
                        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                        calendar = {
                            mode = "month";
                            on-scroll = 1;
                            format = {
                                months = "<span color='${theme.colors.accent.tertiary}'><b>{}</b></span>";
                                days = "<span color='${theme.colors.foreground}'>{}</span>";
                                weekdays = "<span color='${theme.colors.accent.primary}'><b>{}</b></span>";
                                today = "<span color='${theme.colors.accent.secondary}'><b>{}</b></span>";
                            };
                        };
                        actions = {
                            on-click = "mode";
                            on-click-right = "switch-to-default";
                            on-scroll-up = "shift_up";
                            on-scroll-down = "shift_down";
                        };
                    };

                    "cpu" = {
                        interval = 2;
                        format = "󰻠 {usage}%";
                        tooltip = true;
                        max-length = 10;
                        states = {
                            warning = 70;
                            critical = 90;
                        };
                    };

                    "memory" = {
                        interval = 5;
                        format = "󰍛 {percentage}%";
                        tooltip-format = "RAM: {used:0.1f}GB/{total:0.1f}GB";
                        states = {
                            warning = 70;
                            critical = 90;
                        };
                    };

                    "backlight" = {
                        format = "{icon} {percent}%";
                        format-icons = ["󰃛" "󰃜" "󰃝" "󰃞" "󰃟" "󰃠"];
                        on-scroll-up = "light -A 5";
                        on-scroll-down = "light -U 5";
                        smooth-scrolling-threshold = 1;
                    };

                    "battery" = {
                        states = {
                            warning = 30;
                            critical = 15;
                        };
                        format = "{icon} {capacity}%";
                        format-charging = "󰂄 {capacity}%";
                        format-plugged = "󰚥 {capacity}%";
                        format-alt = "{icon} {time}";
                        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                        tooltip-format = "{capacity}% - {time} remaining";
                        interval = 30;
                    };

                    "network" = {
                        format-wifi = "󰤨 {essid}";
                        format-ethernet = "󰈀 Connected";
                        format-linked = "󰌘 Connected";
                        format-disconnected = "󰌙 Disconnected";
                        format-alt = "󱛇 {bandwidthUpBits} | 󱛅 {bandwidthDownBits}";
                        tooltip-format = "Interface: {ifname}\nIP: {ipaddr}\nSignal: {signalStrength}%\nFrequency: {frequency}GHz";
                        on-click-right = "nm-connection-editor";
                    };

                    "pulseaudio" = {
                        format = "{icon} {volume}%";
                        format-bluetooth = "󰂯 {volume}%";
                        format-bluetooth-muted = "󰂲";
                        format-muted = "󰝟";
                        format-icons = {
                            headphone = "󰋋";
                            hands-free = "󱠰";
                            headset = "󰋎";
                            phone = "󰏲";
                            portable = "󰏲";
                            car = "󰄋";
                            default = ["󰕿" "󰖀" "󰕾"];
                        };
                        on-click = "pavucontrol";
                        on-click-middle = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                        on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
                        on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
                        smooth-scrolling-threshold = 1;
                    };

                    "tray" = {
                        icon-size = 18;
                        spacing = 8;
                    };
                };
            };

            style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "${theme.fonts.monospace}";
          font-size: ${toString theme.fonts.size.normal}px;
          font-weight: bold;
          min-height: 0;
          transition-property: background-color, color;
          transition-duration: 0.3s;
        }

        window#waybar {
          background: transparent;
          color: ${theme.colors.foreground};
        }

        tooltip {
          background: ${theme.colors.background};
          border: 1px solid ${theme.colors.accent.primary};
          border-radius: ${toString theme.border.radius}px;
        }

        tooltip label {
          color: ${theme.colors.foreground};
        }

        #workspaces {
          background: rgba(${builtins.substring 1 6 theme.colors.background}, ${toString theme.opacity.panel});
          margin: 3px 3px;
          padding: 0 2px;
          border-radius: ${toString theme.border.radius}px;
          border: 1px solid rgba(${builtins.substring 1 6 theme.colors.accent.primary}, 0.2);
        }

        #workspaces button {
          padding: 0 5px;
          margin: 3px 2px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
          background: transparent;
          transition: all 0.3s ease;
        }

        #workspaces button:hover {
          background: rgba(${builtins.substring 1 6 theme.colors.accent.secondary}, 0.2);
          color: ${theme.colors.accent.primary};
          box-shadow: inherit;
          text-shadow: inherit;
        }

        #workspaces button.active {
          background: linear-gradient(45deg, ${theme.colors.accent.primary}, ${theme.colors.accent.tertiary});
          color: ${theme.colors.background};
          box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
        }

        #workspaces button.urgent {
          background: ${theme.colors.accent.error};
          color: ${theme.colors.background};
        }

        #window {
          background: rgba(${builtins.substring 1 6 theme.colors.background}, ${toString theme.opacity.panel});
          margin: 3px;
          padding: 0 10px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
          border: 1px solid rgba(${builtins.substring 1 6 theme.colors.accent.primary}, 0.2);
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #network,
        #pulseaudio,
        #tray,
        #backlight {
          background: rgba(${builtins.substring 1 6 theme.colors.background}, ${toString theme.opacity.panel});
          padding: 0 10px;
          margin: 3px 2px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
          border: 1px solid rgba(${builtins.substring 1 6 theme.colors.accent.primary}, 0.2);
        }

        #clock {
          color: ${theme.colors.accent.primary};
          margin-left: 0;
          margin-right: 0;
          font-weight: bold;
          background: linear-gradient(45deg, rgba(${builtins.substring 1 6 theme.colors.background}, ${toString theme.opacity.panel}), rgba(${builtins.substring 1 6 theme.colors.accent.primary}, 0.2));
        }

        #battery {
          color: ${theme.colors.accent.secondary};
        }

        #battery.charging, #battery.plugged {
          color: ${theme.colors.accent.secondary};
        }

        #battery.warning:not(.charging) {
          color: ${theme.colors.accent.warning};
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #battery.critical:not(.charging) {
          color: ${theme.colors.accent.error};
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #cpu {
          color: ${theme.colors.accent.quaternary};
        }

        #cpu.warning {
          color: ${theme.colors.accent.warning};
        }

        #cpu.critical {
          color: ${theme.colors.accent.error};
        }

        #memory {
          color: ${theme.colors.accent.tertiary};
        }

        #memory.warning {
          color: ${theme.colors.accent.warning};
        }

        #memory.critical {
          color: ${theme.colors.accent.error};
        }

        #network {
          color: ${theme.colors.accent.primary};
        }

        #network.disconnected {
          color: ${theme.colors.accent.error};
        }

        #pulseaudio {
          color: ${theme.colors.accent.primary};
        }

        #pulseaudio.muted {
          color: ${theme.colors.accent.error};
        }

        #backlight {
          color: ${theme.colors.accent.quaternary};
        }

        #tray {
          margin-right: 5px;
          border-radius: ${toString theme.border.radius}px;
        }

        @keyframes blink {
          to {
            background-color: ${theme.colors.accent.error};
            color: ${theme.colors.background};
          }
        }
            '';
        };
    };
} 
