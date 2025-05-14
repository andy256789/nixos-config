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
                    height = 32;
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
          background: rgba(30, 30, 46, ${toString theme.opacity.panel});
          margin: 3px 3px;
          padding: 0 2px;
          border-radius: ${toString theme.border.radius}px;
          border: 1px solid rgba(137, 180, 250, 0.2);
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
          background: rgba(166, 227, 161, 0.2);
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
          background: rgba(30, 30, 46, ${toString theme.opacity.panel});
          margin: 3px;
          padding: 0 10px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
          border: 1px solid rgba(137, 180, 250, 0.2);
        }

        #clock,
        #cpu,
        #memory,
        #network,
        #pulseaudio,
        #tray {
          background: rgba(30, 30, 46, ${toString theme.opacity.panel});
          padding: 0 10px;
          margin: 3px 2px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
          border: 1px solid rgba(137, 180, 250, 0.2);
        }

        #clock {
          color: ${theme.colors.accent.primary};
          margin-left: 0;
          margin-right: 0;
          font-weight: bold;
          background: linear-gradient(45deg, rgba(30, 30, 46, ${toString theme.opacity.panel}), rgba(137, 180, 250, 0.2));
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
