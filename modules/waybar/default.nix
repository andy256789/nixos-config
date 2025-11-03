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
                    height = 33;
                    margin = "3, 0, 2, 0";
                    spacing = 0;
                    modules-left = [
                        "hyprland/workspaces"
                        "hyprland/window"
                    ];
                    modules-center = [
                        "clock"
                    ];
                    modules-right = [
                        "tray"
                        "custom/separator"
                        "backlight"
                        "custom/separator"
                        "pulseaudio"
                        "custom/separator"
                        "battery"
                        "custom/power"
                    ];

                    "hyprland/workspaces" = {
                        format = "{icon}";
                        persistent-workspaces = {
                            "*" = [1 2 3 4 5];
                        };
                        format-icons = {
                            "1" = "1";
                            "2" = "2";
                            "3" = "3";
                            "4" = "4";
                            "5" = "5";
                            "6" = "6";
                            "7" = "7";
                            "8" = "8";
                            "9" = "9";
                            "urgent" = "";
                            "focused" = "";
                            "default" = "";
                        };
                        on-click = "activate";
                        on-scroll-up = "hyprctl dispatch workspace e+1";
                        on-scroll-down = "hyprctl dispatch workspace e-1";
                        all-outputs = true;
                        active-only = false;
                        show-special = false;
                    };

                    "custom/separator" = {
                        format = "|";
                        interval = "once";
                        tooltip = false;
                    };

                    "hyprland/window" = {
                        format = "{}";
                        max-length = 30;
                        separate-outputs = true;
                    };

                    "clock" = {
                        interval = 1;
                        format = " {:%I:%M %p}";
                        format-alt = " {:%a, %b %d}";
                        actions = {
                            on-click = "mode";
                        };
                        tooltip = false;
                    };

                    "tray" = {
                        icon-size = 20;
                        spacing = 6;
                    };

                    "backlight" = {
                        format = "{icon} {percent}%";
                        format-icons = ["󰃞" "󰃟" "󰃝" "󰃠"];
                        tooltip = true;
                        tooltip-format = "Brightness: {percent}%";
                        on-scroll-up = "brightnessctl set 1%+";
                        on-scroll-down = "brightnessctl set 1%-";
                        states = {
                            warning = 20;
                            critical = 10;
                        };
                    };

                    "pulseaudio" = {
                        format = "{icon} {volume}%";
                        format-muted = "  0%";
                        format-bluetooth = "󰥰 {volume}%";
                        format-bluetooth-muted = "󰥰 0%";
                        format-icons = {
                            headphone = "";
                            hands-free = "";
                            headset = "";
                            phone = "";
                            car = "";
                            default = [" " " " " "];
                        };
                        on-click = "pavucontrol";
                        on-click-middle = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                        on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
                        on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
                    };

                    "battery" = {
                        bat = "BAT0";  # FIXED: Added battery identifier
                        adapter = "AC";  # FIXED: Added AC adapter identifier
                        interval = 60;  # FIXED: Added refresh interval
                        states = {
                            warning = 30;
                            critical = 15;
                        };
                        format = "{icon} {capacity}%";
                        format-charging = " 󱐋{capacity}%";
                        format-plugged = " {capacity}%";  # FIXED: Added plugged format
                        format-alt = "{icon} {time}";
                        tooltip = true;
                        format-icons = ["󰂎" "󰁼" "󰁿" "󰂁" "󰁹"];
                        tooltip-format = "Time: {time}\nPower: {power}W";
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
          font-family: "${theme.fonts.monospace}", "JetBrainsMono";
          font-size: ${toString theme.fonts.size.normal}px;
          font-weight: bold;
          min-height: 0;
          transition-property: background-color;
          transition-duration: 0.3s;
        }

        window#waybar {
          background: rgba(34, 36, 54, 0.6);
          color: ${theme.colors.foreground};
          transition-property: background-color;
          transition-duration: 0.5s;
          border-radius: 4px;
        }

        window#waybar.hidden {
          opacity: 0.2;
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
          margin: 0 4px;
          padding: 0;
        }

        #workspaces button {
          padding: 0px;
          margin: 4px 0 6px 0;
          background-color: transparent;
          color: ${theme.colors.foreground};
          min-width: 36px;
          border-radius: 0;
          transition: background-color 0.3s ease;
        }

        #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
          color: ${theme.colors.accent.primary};
        }

        #workspaces button.active {
          padding: 0 0 0 0;
          margin: 4px 0 6px 0;
          background-color: #ddddff;
          color: #303030;
          min-width: 36px;
        }

        #workspaces button.focused {
          background-color: #bbccdd;
          color: #323232;
        }

        #workspaces button.urgent {
          color: ${theme.colors.accent.error};
        }

        #window {
          margin: 0 4px;
          padding: 0px 3px;
          color: ${theme.colors.foreground};
          background-color: transparent;
        }

        #clock,
        #battery,
        #backlight,
        #pulseaudio,
        #bluetooth,
        #tray,
        #custom-power {
          min-width: 50px;
          padding: 0px 3px;
          margin: 4px 3px 5px 3px;
          color: ${theme.colors.foreground};
          background-color: transparent;
          transition: all 0.3s ease;
        }

        #custom-separator {
          color: #606060;
          margin: 0 4px;
          padding: 0;
          background-color: transparent;
          font-size: ${toString (theme.fonts.size.normal - 2)}px;
          font-weight: normal;
        }

        #clock {
          color: #90ee90;
          font-weight: bold;
        }

        #pulseaudio {
          color: #bb9af7;
        }

        #pulseaudio.muted {
          color: #a0a0a0;
        }

        #backlight {
          color: #b9f27c;
        }

        #backlight.warning {
          color: ${theme.colors.accent.warning};
        }

        #backlight.critical {
          color: ${theme.colors.accent.error};
        }

        #battery {
          color: #7da6ff;
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
          animation: blink 0.5s linear infinite alternate;
        }

        @keyframes blink {
          to {
            background-color: ${theme.colors.accent.error};
            color: ${theme.colors.background};
          }
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

        #bluetooth:hover,
        #custom-power:hover,
        #pulseaudio:hover,
        #backlight:hover,
        #battery:hover{
          background: ${theme.utils.hexToRgba theme.colors.accent.primary 0.2};
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
            '';
        };
    };
}
