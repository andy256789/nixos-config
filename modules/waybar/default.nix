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
                    spacing = 4;
                    margin-top = 4;
                    margin-bottom = 0;
                    margin-left = 4;
                    margin-right = 4;
                    modules-left = [
                        "hyprland/workspaces"
                        "hyprland/window"
                    ];
                    modules-center = [
                        "clock"
                    ];
                    modules-right = [
                        "cpu"
                        "memory"
                        "custom/separator"
                        "tray"
                        "custom/separator"
                        "backlight"
                        "pulseaudio"
                        "battery"
                        "custom/power"
                    ];

                    "hyprland/workspaces" = {
                        format = "{icon}";
                        format-icons = {
                            "1" = "𝟷";
                            "2" = "𝟸";
                            "3" = "𝟹";
                            "4" = "𝟺";
                            "5" = "𝟻";
                            "6" = "𝟼";
                            "7" = "𝟽";
                            "8" = "𝟾";
                            "9" = "𝟿";
                            "urgent" = "";
                            "focused" = "";
                            "default" = "";
                        };
                        sort-by-number = true;
                        on-click = "activate";
                        on-scroll-up = "hyprctl dispatch workspace e+1";
                        on-scroll-down = "hyprctl dispatch workspace e-1";
                        all-outputs = true;
                        active-only = false;
                        show-special = false;
                        persistent-workspaces = {
                            "1" = [];
                            "2" = [];
                            "3" = [];
                            "4" = [];
                            "5" = [];
                        };
                    };

                    "hyprland/window" = {
                        format = " {}";
                        max-length = 35;
                        separate-outputs = true;
                        rewrite = {
                            "(.*) — Mozilla Firefox" = "󰈹 $1";
                            "(.*) - Visual Studio Code" = "󰨞 $1";
                            "(.*) - vim" = " $1";
                            "ghostty" = " Terminal";
                        };
                    };

                    "clock" = {
                        interval = 1;
                        locale = "C";
                        format = "󰥔 {:%H:%M}";
                        format-alt = "󰸗 {:%A, %B %d, %Y}";
                        tooltip-format = "{:%A, %B %d, %Y at %H:%M:%S}";
                    };

                    "cpu" = {
                        format = "󰻠 {usage}%";
                        tooltip-format = "CPU Usage: {usage}%\nLoad: {load}";
                        on-click = "ghostty -e htop";
                        interval = 3;
                    };

                    "memory" = {
                        interval = 10;
                        format = "󰍛 {percentage}%";
                        tooltip-format = "RAM: {used:0.1f}GB / {total:0.1f}GB ({percentage}%)";
                        max-length = 10;
                        warning = 70;
                        critical = 90;
                    };

                    "pulseaudio" = {
                        format = "{icon} {volume}%";
                        format-bluetooth = "󰂰 {volume}%";
                        format-bluetooth-muted = "󰂲 Muted";
                        format-muted = "󰖁 Muted";
                        format-source = "󰍬 {volume}%";
                        format-source-muted = "󰍭 Muted";
                        format-icons = {
                            headphone = "󰋋";
                            hands-free = "󱠰";
                            headset = "󰋎";
                            phone = "󰏲";
                            portable = "󰏲";
                            car = "󰄋";
                            default = ["󰕿" "󰖀" "󰕾"];
                        };
                        scroll-step = 5;
                        on-click = "pavucontrol";
                        on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                        tooltip-format = "Volume: {volume}%";
                    };

                    "battery" = {
                        states = {
                            warning = 30;
                            critical = 15;
                        };
                        format = "{icon} {capacity}%";
                        format-charging = "󰂄 {capacity}%";
                        format-plugged = "󱘖 {capacity}%";
                        format-alt = "{icon} {time}";
                        format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
                        tooltip-format = "Battery: {capacity}%\n{timeTo}";
                    };

                    "backlight" = {
                        format = "{icon} {percent}%";
                        format-icons = ["󰃞" "󰃟" "󰃠"];
                        on-scroll-down = "brightnessctl set 5%-";
                        on-scroll-up = "brightnessctl set +5%";
                        tooltip-format = "Brightness: {percent}%";
                    };

                    "tray" = {
                        icon-size = 18;
                        spacing = 8;
                        show-passive-items = true;
                    };

                    "custom/power" = {
                        format = "󰐥";
                        tooltip-format = "Power Menu";
                        on-click = "wlogout";
                        on-click-right = "systemctl poweroff";
                        on-click-middle = "systemctl reboot";
                    };

                    "custom/separator" = {
                        format = "|";
                        tooltip = false;
                    };
                };
            };

            style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free Solid", "${theme.fonts.monospace}";
          font-size: ${toString theme.fonts.size.normal}px;
          font-weight: 600;
          min-height: 0;
          transition: all 0.3s cubic-bezier(0.4, 0.0, 0.2, 1);
        }

        window#waybar {
          background: linear-gradient(135deg, rgba(30, 32, 48, 0.5), rgba(24, 26, 38, 0.55));
          color: ${theme.colors.foreground};
          border-radius: 8px;
          margin: 4px 8px 0px 8px;
          padding: 3px 0px;
          box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3), 
                      0 2px 8px rgba(0, 0, 0, 0.15),
                      inset 0 1px 0 rgba(255, 255, 255, 0.05);
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        tooltip {
          background: linear-gradient(135deg, ${theme.colors.background}, rgba(34, 36, 54, 0.98));
          color: ${theme.colors.foreground};
          border: 1px solid ${theme.colors.accent.primary};
          border-radius: 8px;
          box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
          padding: 8px 12px;
        }

        tooltip label {
          color: ${theme.colors.foreground};
          font-weight: 500;
        }

        /* Left modules - Workspaces and Navigation */
        #workspaces {
          margin: 3px 4px;
          padding: 2px 4px;
          background: rgba(0, 0, 0, 0.5);
          border-radius: 6px;
        }

        #workspaces button {
          padding: 0;
          margin: 1px 2px;
          background: rgba(0, 0, 0, 0.4);
          color: ${theme.colors.foreground};
          min-width: 20px;
          min-height: 20px;
          border-radius: 4px;
          transition: none;
          border: 1px solid transparent;
          font-size: ${toString (theme.fonts.size.normal - 1)}px;
        }

        #workspaces button:hover {
          background: ${theme.utils.hexToRgba theme.colors.accent.primary 0.15};
          color: ${theme.colors.accent.primary};
          box-shadow: 0 4px 12px ${theme.utils.hexToRgba theme.colors.accent.primary 0.2};
          border: 1px solid ${theme.utils.hexToRgba theme.colors.accent.primary 0.3};
        }

        #workspaces button.active {
          background: linear-gradient(135deg, ${theme.colors.accent.primary}, ${theme.utils.hexToRgba theme.colors.accent.primary 0.8});
          color: ${theme.colors.background};
          box-shadow: 0 4px 16px ${theme.utils.hexToRgba theme.colors.accent.primary 0.4},
                      inset 0 1px 0 rgba(255, 255, 255, 0.2);
          border: 1px solid ${theme.utils.hexToRgba theme.colors.accent.primary 0.5};
        }

        #workspaces button.urgent {
          background: linear-gradient(135deg, ${theme.colors.accent.error}, ${theme.utils.hexToRgba theme.colors.accent.error 0.8});
          color: ${theme.colors.background};
          box-shadow: 0 4px 20px ${theme.utils.hexToRgba theme.colors.accent.error 0.6};
        }

        #window {
          color: ${theme.colors.foreground};
          background: rgba(0, 0, 0, 0.5);
          border-radius: 4px;
          margin: 3px 2px;
          padding: 0 8px;
        }

        /* Center modules - System Info and Clock */
        #cpu, #memory {
          margin: 3px 2px;
          padding: 0 6px;
          border-radius: 4px;
          background: rgba(0, 0, 0, 0.5);
        }

        #cpu {
          color: #ff7a93;
        }

        #memory {
          color: #86e2d5;
        }

        #clock {
          color: #7dcfff;
          background: rgba(0, 0, 0, 0.5);
          margin: 3px 4px;
          padding: 0 10px;
          border-radius: 4px;
          font-weight: 600;
          min-width: 80px;
        }

        /* Right modules */
        #tray,
        #backlight,
        #battery,
        #pulseaudio,
        #custom-power {
          margin: 3px 1px;
          padding: 0 6px;
          border-radius: 4px;
          background: rgba(0, 0, 0, 0.5);
          transition: all 0.3s cubic-bezier(0.4, 0.0, 0.2, 1);
        }

        #custom-separator {
          color: ${theme.utils.hexToRgba theme.colors.foreground 0.3};
          background: transparent;
          margin: 3px 4px;
          padding: 0;
          font-size: ${toString (theme.fonts.size.normal - 2)}px;
        }

        #pulseaudio {
          color: #bb9af7;
        }

        #pulseaudio.muted {
          color: rgba(187, 154, 247, 0.5);
          background: rgba(0, 0, 0, 0.2);
        }

        #cpu.warning,
        #memory.warning,
        #backlight.warning {
          color: ${theme.colors.accent.warning};
          background: ${theme.utils.hexToRgba theme.colors.accent.warning 0.15};
        }

        #cpu.critical,
        #memory.critical,
        #backlight.critical {
          color: ${theme.colors.accent.error};
          background: ${theme.utils.hexToRgba theme.colors.accent.error 0.15};
          box-shadow: 0 2px 8px ${theme.utils.hexToRgba theme.colors.accent.error 0.4};
        }

        #backlight {
          color: #9ece6a;
        }

        #battery {
          color: #7aa2f7;
        }

        #battery.charging {
          color: ${theme.colors.accent.secondary};
          background: ${theme.utils.hexToRgba theme.colors.accent.secondary 0.1};
        }

        #battery.plugged {
          color: ${theme.colors.accent.primary};
        }

        #battery.warning:not(.charging) {
          color: ${theme.colors.accent.warning};
          background: ${theme.utils.hexToRgba theme.colors.accent.warning 0.15};
        }

        #battery.critical:not(.charging) {
          color: ${theme.colors.accent.error};
          background: ${theme.utils.hexToRgba theme.colors.accent.error 0.15};
          box-shadow: 0 2px 8px ${theme.colors.accent.error};
        }

        #tray {
          background: rgba(0, 0, 0, 0.5);
          margin: 3px 4px;
          padding: 0 8px;
          border-radius: 4px;
          min-height: 0;
        }        #custom-power {
          color: ${theme.colors.accent.error};
          background: rgba(0, 0, 0, 0.3);
          margin-right: 4px;
          padding: 0;
          min-width: 24px;
          min-height: 24px;
          border-radius: 4px;
          font-size: ${toString (theme.fonts.size.normal + 1)}px;
        }

        #custom-power:hover {
          background: rgba(0, 0, 0, 0.4);
          box-shadow: 0 4px 12px ${theme.utils.hexToRgba theme.colors.accent.error 0.3};
        }

        /* Hover effects for all modules */
        #pulseaudio:hover,
        #cpu:hover,
        #memory:hover,
        #backlight:hover,
        #battery:hover,
        #clock:hover,
        #window:hover {
          background: rgba(0, 0, 0, 0.4);
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
           '';
        };
    };
}
