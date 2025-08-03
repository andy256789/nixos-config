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
                    spacing = 0;
                    modules-left = [
                        "hyprland/workspaces"
                        "custom/lock"
                        "custom/reboot"
                        "custom/power"
                        "hyprland/window"
                    ];
                    modules-center = [
                        "clock"
                    ];
                    modules-right = [
                        "pulseaudio"
                        "backlight"
                        "custom/temperature"
                        "memory"
                        "cpu"
                        "tray"
                        "battery"
                    ];

                    "hyprland/workspaces" = {
                        disable-scroll = false;
                        all-outputs = true;
                        format = "{icon}";
                        on-click = "activate";
                        persistent-workspaces = {
                            "*" = [1 2 3 4 5];
                        };
                        format-icons = {
                            "1" = "";
                            "2" = "󰈹";
                            "3" = "";
                            "4" = "";
                            "5" = "";
                            "6" = "";
                            "7" = "";
                            "8" = "";
                            "9" = "";
                            "default" = "";
                        };
                    };

                    "custom/lock" = {
                        format = "<span color='#00FFFF'>  </span>";
                        on-click = "hyprlock";
                        tooltip = true;
                        tooltip-format = "锁屏";
                    };

                    "custom/reboot" = {
                        format = "<span color='#FFD700'>  </span>";
                        on-click = "systemctl reboot";
                        tooltip = true;
                        tooltip-format = "重启";
                    };

                    "custom/power" = {
                        format = "<span color='#FF4040'>  </span>";
                        on-click = "systemctl poweroff";
                        tooltip = true;
                        tooltip-format = "关机";
                    };

                    "hyprland/window" = {
                        format = "{class}";
                        max-length = 50;
                        separate-outputs = true;
                        rewrite = {
                            "(.*) — Mozilla Firefox" = "󰈹 $1";
                            "(.*) - Visual Studio Code" = "󰨞 $1";
                            "(.*) - vim" = " $1";
                            "ghostty" = " ";
                        };
                    };

                    "network" = {
                        format-wifi = "<span color='#00FFFF'> 󰤨 </span>{essid} ";
                        format-ethernet = "<span color='#7FFF00'>  </span>Wired ";
                        tooltip-format = "<span color='#FF1493'> 󰅧 </span>{bandwidthUpBytes}  <span color='#00BFFF'> 󰅢 </span>{bandwidthDownBytes}";
                        format-linked = "<span color='#FFA500'> 󱘖 </span>{ifname} (No IP) ";
                        format-disconnected = "<span color='#FF4040'>  </span>Disconnected ";
                        format-alt = "<span color='#00FFFF'> 󰤨 </span>{signalStrength}% ";
                        interval = 1;
                    };

                    "battery" = {
                        states = {
                            warning = 30;
                            critical = 15;
                        };
                        format = "<span color='#28CD41'> {icon} </span>{capacity}% ";
                        format-charging = " 󱐋{capacity}%";
                        interval = 1;
                        format-icons = ["󰂎" "󰁼" "󰁿" "󰂁" "󰁹"];
                        tooltip = true;
                    };

                    "pulseaudio" = {
                        format = "<span color='#00FF7F'>{icon}</span>{volume}% ";
                        format-muted = "<span color='#FF4040'> 󰖁 </span>0% ";
                        format-icons = {
                            headphone = "<span color='#BF00FF'>  </span>";
                            hands-free = "<span color='#BF00FF'>  </span>";
                            headset = "<span color='#BF00FF'>  </span>";
                            phone = "<span color='#00FFFF'>  </span>";
                            car = "<span color='#FFA500'>  </span>";
                            default = [
                                "<span color='#808080'>  </span>"
                                "<span color='#FFFF66'>  </span>"
                                "<span color='#00FF7F'>  </span>"
                            ];
                        };
                        on-click-right = "pavucontrol -t 3";
                        on-click = "pactl -- set-sink-mute 0 toggle";
                        tooltip = true;
                        tooltip-format = "当前系统声音: {volume}%";
                    };

                    "backlight" = {
                        device = "intel_backlight";
                        format = "<span color='#FFD700'>{icon}</span>{percent}% ";
                        tooltip = true;
                        tooltip-format = "当前屏幕亮度: {percent}%";
                        format-icons = [
                            "<span color='#696969'> 󰃞 </span>"
                            "<span color='#A9A9A9'> 󰃝 </span>"
                            "<span color='#FFFF66'> 󰃟 </span>"
                            "<span color='#FFD700'> 󰃠 </span>"
                        ];
                    };

                    "custom/temperature" = {
                        exec = "sensors | awk '/^Package id 0:/ {print int($4)}'";
                        format = "<span color='#FFA500'> </span>{}°C ";
                        interval = 5;
                        tooltip = true;
                        tooltip-format = "当前 CPU 温度: {}°C";
                    };

                    "memory" = {
                        format = "<span color='#8A2BE2'>  </span>{used:0.1f}G/{total:0.1f}G ";
                        tooltip = true;
                        tooltip-format = "当前内存占比: {used:0.2f}G/{total:0.2f}G";
                    };

                    "cpu" = {
                        format = "<span color='#FF9F0A'>  </span>{usage}% ";
                        tooltip = true;
                    };

                    "clock" = {
                        interval = 1;
                        timezone = "Europe/Sofia";
                        format = "<span color='#BF00FF'>  </span>{:%H:%M} ";
                        tooltip = true;
                        tooltip-format = "{:L%Y 年 %m 月 %d 日, %A}";
                    };

                    "tray" = {
                        icon-size = 17;
                        spacing = 6;
                    };
                };
            };

            style = ''
        /* 全局设置 */
        * {
          font-family: "CaskaydiaCove Nerd Font", "Font Awesome 6 Free", "Font Awesome 6 Free Solid";
          font-weight: bold;
          font-size: 16px;
          color: #dcdfe1;
        }

        /* 透明 Waybar 背景 */
        #waybar {
          background-color: rgba(0, 0, 0, 0);
          border: none;
          box-shadow: none;
        }

        #workspaces,
        #window,
        #tray{
          background-color: rgba(15,27,53,0.9);
          padding: 4px 6px; 
          margin-top: 6px; 
          margin-left: 6px;
          margin-right: 6px;
          border-radius: 10px;
          border-width: 0px;
        }

        #clock,
        #custom-power{
          background-color: rgba(15,27,53,0.9);
          margin-top: 6px;
          margin-right: 6px;
          padding: 4px 2px;
          border-radius: 0 10px 10px 0;
          border-width: 0px;
        }

        #network,
        #custom-lock{
          background-color: rgba(15,27,53,0.9);
          margin-top: 6px;
          margin-left: 6px;
          padding: 4px 2px;
          border-radius: 10px 0 0 10px;
          border-width: 0px;
        }

        #custom-reboot,
        #bluetooth,
        #battery,
        #pulseaudio,
        #backlight,
        #custom-temperature,
        #memory,
        #cpu{
          background-color: rgba(15,27,53,0.9);
          margin-top: 6px;
          padding: 4px 2px;
          border-width: 0px;
        }

        #custpm-temperature.critical,
        #pulseaudio.muted {
          color: #FF0000;
          padding-top: 0;
        }

        #bluetooth:hover,
        #network:hover,
        /*#tray:hover,*/
        #backlight:hover,
        #battery:hover,
        #pulseaudio:hover,
        #custom-temperature:hover,
        #memory:hover,
        #cpu:hover,
        #clock:hover,
        #custom-lock:hover,
        #custom-reboot:hover,
        #custom-power:hover,
        /*#workspaces:hover,*/
        #window:hover {
          background-color: rgba(70, 75, 90, 0.9);
        }

        #workspaces button:hover{
          background-color: rgba(97, 175, 239, 0.2);
          padding: 2px 8px;
          margin: 0 2px;
          border-radius: 10px;
        }

        #workspaces button.active {
          background-color: #61afef;
          color: #ffffff;
          padding: 2px 8px;
          margin: 0 2px;
          border-radius: 10px;
        }

        #workspaces button {
          background: transparent;
          border: none;
          color: #888888;
          padding: 2px 8px;
          margin: 0 2px;
          font-weight: bold;
        }

        #window {
          font-weight: 500;
          font-style: italic;
        }
           '';
        };
    };
}
