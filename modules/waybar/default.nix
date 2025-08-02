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
                        "bluetooth"
                        "pulseaudio"
                        "cpu"
                        "memory"
                        "backlight"
                        "battery"
                        "tray"
                        "custom/power"
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

                    "bluetooth" = {
                        format = "";
                        format-connected = "󰂱 {device_alias}";
                        format-connected-battery = "󰂱 {device_alias} ({device_battery_percentage}%)";
                        format-disabled = "󰂲";
                        format-off = "󰂲";
                        tooltip-format = "Bluetooth: {status}";
                        tooltip-format-connected = "Bluetooth: {status}\nConnected devices:\n{device_enumerate}";
                        tooltip-format-enumerate-connected = "• {device_alias}\t{device_address}";
                        tooltip-format-enumerate-connected-battery = "• {device_alias}\t{device_address}\t({device_battery_percentage}%)";
                        on-click = "blueman-manager";
                        on-click-right = "bluetoothctl power toggle";
                        max-length = 25;
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
                        max-length = 15;
                    };

                    "battery" = {
                        states = {
                            warning = 20;
                            critical = 10;
                        };
                        format = "{icon} {capacity}%";
                        format-charging = "󰂄 {capacity}%";
                        format-plugged = "󰂄 {capacity}%";
                        format-alt = "{time} {capacity}%";
                        tooltip = true;
                        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                        tooltip-format = "Battery: {capacity}%\nTime: {time}\nPower: {power}W";
                    };

                    "backlight" = {
                        format = "󰃠 {percent}%";
                        tooltip = true;
                        on-scroll-up = "brightnessctl set 5%+";
                        on-scroll-down = "brightnessctl set 5%-";
                        min-length = 8;
                        states = {
                            warning = 20;
                            critical = 10;
                        };
                        tooltip-format = "Brightness: {percent}%";
                    };

                    "tray" = {
                        icon-size = 18;
                        spacing = 8;
                    };

                    "custom/power" = {
                        format = "⏻";
                        tooltip = false;
                        on-click = "wlogout";
                        on-click-right = "systemctl poweroff";
                        on-click-middle = "systemctl reboot";
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
          background: ${theme.utils.hexToRgba theme.colors.background theme.opacity.panel};
          margin: 3px 3px;
          padding: 0 2px;
          border-radius: ${toString theme.border.radius}px;
          border: 1px solid ${theme.utils.hexToRgba theme.colors.accent.primary 0.2};
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
          background: ${theme.utils.hexToRgba theme.colors.accent.secondary 0.2};
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
          background: ${theme.utils.hexToRgba theme.colors.background theme.opacity.panel};
          margin: 3px;
          padding: 0 10px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
          border: 1px solid ${theme.utils.hexToRgba theme.colors.accent.primary 0.2};
        }

        #clock,
        #battery,
        #backlight,
        #cpu,
        #memory,
        #network,
        #pulseaudio,
        #bluetooth,
        #tray,
        #custom-power {
          background: ${theme.utils.hexToRgba theme.colors.background theme.opacity.panel};
          padding: 0 10px;
          margin: 3px 2px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
          border: 1px solid ${theme.utils.hexToRgba theme.colors.accent.primary 0.2};
          transition: all 0.3s ease;
        }

        #clock {
          color: ${theme.colors.accent.primary};
          margin-left: 0;
          margin-right: 0;
          font-weight: bold;
          background: ${theme.colors.background};
        }

        #bluetooth {
          color: ${theme.colors.accent.primary};
        }

        #bluetooth.disabled,
        #bluetooth.off {
          color: ${theme.colors.accent.error};
        }

        #bluetooth.connected {
          color: ${theme.colors.accent.secondary};
        }

        #pulseaudio {
          color: ${theme.colors.accent.primary};
        }

        #pulseaudio.muted {
          color: ${theme.colors.accent.error};
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

        #backlight {
          color: ${theme.colors.accent.secondary};
          min-width: 60px;
        }

        #backlight.warning {
          color: ${theme.colors.accent.warning};
        }

        #backlight.critical {
          color: ${theme.colors.accent.error};
        }

        #battery {
          color: ${theme.colors.accent.secondary};
          min-width: 60px;
        }

        #battery.charging {
          color: ${theme.colors.accent.primary};
        }

        #battery.plugged {
          color: ${theme.colors.accent.primary};
        }

        #battery.warning:not(.charging) {
          color: ${theme.colors.accent.warning};
        }

        #battery.critical:not(.charging) {
          color: ${theme.colors.accent.error};
        }

        #tray {
          border-radius: ${toString theme.border.radius}px;
        }

        #custom-power {
          color: ${theme.colors.accent.error};
          font-size: ${toString (theme.fonts.size.normal + 2)}px;
          min-width: 28px;
          margin-right: 5px;
        }

        #custom-power:hover {
          color: ${theme.colors.accent.error};
        }

        #bluetooth:hover,
        #custom-power:hover,
        #network:hover,
        #pulseaudio:hover,
        #cpu:hover,
        #memory:hover,
        #backlight:hover,
        #battery:hover {
          background: ${theme.utils.hexToRgba theme.colors.accent.primary 0.2};
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
           '';
        };
    };
}
