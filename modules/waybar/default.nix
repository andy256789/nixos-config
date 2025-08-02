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
                    width = 1350;
                    margin = "3, 0, 2, 0";
                    spacing = 0;
                    modules-left = [
                        "custom/wmname"
                        "hyprland/workspaces"
                        "hyprland/window"
                        "custom/separator"
                        "cpu"
                        "custom/separator"
                        "memory"
                        "custom/separator"
                        "network"
                    ];
                    modules-center = [
                        "tray"
                        "clock"
                    ];
                    modules-right = [
                        "idle_inhibitor"
                        "custom/separator"
                        "backlight"
                        "custom/separator"
                        "battery"
                        "custom/separator"
                        "pulseaudio"
                        "custom/separator"
                        "bluetooth"
                        "custom/separator"
                        "custom/power"
                    ];

                    "hyprland/workspaces" = {
                        format = "{icon}";
                        format-icons = {
                            "1" = "";
                            "2" = "";
                            "3" = "";
                            "4" = "";
                            "5" = "";
                            "6" = "";
                            "7" = "";
                            "8" = "";
                            "9" = "";
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
                    };

                    "custom/wmname" = {
                        format = "";
                        tooltip = false;
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

                    "network" = {
                        format-wifi = " ({signalStrength}%)";
                        format-ethernet = " {ifname}: {ipaddr}/{cidr}";
                        format-linked = " {ifname} (No IP)";
                        format-disconnected = "✈ Disconnected";
                        format-alt = "{ifname}: {ipaddr}/{cidr}";
                        tooltip-format = "{essid}: {ipaddr}";
                        on-click = "nm-connection-editor";
                    };

                    "idle_inhibitor" = {
                        format = "{icon}";
                        format-icons = {
                            activated = "";
                            deactivated = "";
                        };
                        tooltip-format-activated = "Idle inhibitor: ON";
                        tooltip-format-deactivated = "Idle inhibitor: OFF";
                    };

                    "clock" = {
                        interval = 1;
                        format = " {:%I:%M %p}";
                        format-alt = " {:%a, %b %d}";
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
                        format = " {usage}%";
                        tooltip = true;
                        max-length = 10;
                        states = {
                            warning = 70;
                            critical = 90;
                        };
                        on-click = "kitty -e htop";
                    };

                    "memory" = {
                        interval = 5;
                        format = " {used:0.2f}GB";
                        tooltip-format = "RAM: {used:0.1f}GB/{total:0.1f}GB ({percentage}%)";
                        max-length = 15;
                        states = {
                            warning = 70;
                            critical = 90;
                        };
                    };

                    "pulseaudio" = {
                        format = "{icon} {volume}% {format_source}";
                        format-bluetooth = "{icon} {volume}% {format_source}";
                        format-bluetooth-muted = " {format_source}";
                        format-muted = " {format_source}";
                        format-source = " {volume}%";
                        format-source-muted = "";
                        format-icons = {
                            headphone = "";
                            hands-free = "";
                            headset = "🎧";
                            phone = "";
                            portable = "";
                            car = "";
                            default = ["" "" ""];
                        };
                        on-click = "pavucontrol";
                        on-click-middle = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
                        on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
                        on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
                        smooth-scrolling-threshold = 1;
                        max-length = 20;
                    };

                    "battery" = {
                        states = {
                            warning = 30;
                            critical = 15;
                        };
                        format = "{icon} {capacity}%";
                        format-charging = " {capacity}%";
                        format-plugged = " {capacity}%";
                        format-alt = "{icon} {time}";
                        tooltip = true;
                        format-icons = ["" "" "" "" ""];
                        tooltip-format = "Battery: {capacity}%\nTime: {time}\nPower: {power}W";
                    };

                    "backlight" = {
                        format = "{icon} {percent}%";
                        format-icons = ["💡" "💡"];
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
                        icon-size = 20;
                        spacing = 6;
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
          transition-property: background-color, color;
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
          transition: all 0.3s ease;
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
        #cpu,
        #memory,
        #network,
        #pulseaudio,
        #bluetooth,
        #tray,
        #idle_inhibitor,
        #custom-power,
        #custom-wmname {
          padding: 0px 3px;
          margin: 4px 3px 5px 3px;
          color: ${theme.colors.foreground};
          background-color: transparent;
          transition: all 0.3s ease;
        }

        #custom-separator {
          color: #606060;
          margin: 0 1px;
          padding-bottom: 5px;
          background-color: transparent;
        }

        #custom-wmname {
          min-width: 36px;
          font-size: ${toString (theme.fonts.size.normal + 1)}px;
          color: ${theme.colors.accent.primary};
        }

        #clock {
          color: #90ee90;
          font-weight: bold;
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
          color: #bb9af7;
        }

        #pulseaudio.muted {
          color: #a0a0a0;
        }

        #cpu {
          color: #ff7a93;
        }

        #cpu.warning {
          color: ${theme.colors.accent.warning};
        }

        #cpu.critical {
          color: ${theme.colors.accent.error};
        }

        #memory {
          color: #86e2d5;
        }

        #memory.warning {
          color: ${theme.colors.accent.warning};
        }

        #memory.critical {
          color: ${theme.colors.accent.error};
        }

        #network {
          color: #ff9e64;
        }

        #network.disconnected {
          color: ${theme.colors.accent.error};
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

        #idle_inhibitor {
          color: #0db9d7;
        }

        #idle_inhibitor.activated {
          background-color: #343434;
          border-radius: 4px;
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
        #network:hover,
        #pulseaudio:hover,
        #cpu:hover,
        #memory:hover,
        #backlight:hover,
        #battery:hover,
        #idle_inhibitor:hover {
          background: ${theme.utils.hexToRgba theme.colors.accent.primary 0.2};
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
           '';
        };
    };
}
