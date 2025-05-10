{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/taskbar"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "keyboard-state"
          "sway/language"
          "battery"
          "clock"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          sort-by-number = true;
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 50;
        };

        "hyprland/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
        };

        "clock" = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'>{}</span>";
              weekdays = "<span color='#ecc6d9'>{}</span>";
              today = "<span color='#ffcc66'><b>{}</b></span>";
            };
          };
        };

        "cpu" = {
          format = " {usage}%";
          tooltip = true;
        };

        "memory" = {
          format = " {}%";
          tooltip-format = "{used:0.1f}GB/{total:0.1f}GB used";
        };

        "temperature" = {
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = ["❄️" "🔥"];
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = ["🌑" "🌘" "🌗" "🌖" "🌕"];
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "⚡ {capacity}%";
          format-plugged = "🔌 {capacity}%";
          format-icons = ["🔋" "🔋" "🔋" "🔋" "🔋"];
        };

        "network" = {
          format-wifi = "📶 {essid} ({signalStrength}%)";
          format-ethernet = "🌐 {ipaddr}/{cidr}";
          format-linked = "🌐 {ifname} (No IP)";
          format-disconnected = "⚠️ Disconnected";
          format-alt = "🌐 {ifname}: {ipaddr}/{cidr}";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "🔇";
          format-icons = {
            headphone = "🎧";
            hands-free = "🎧";
            headset = "🎧";
            phone = "📱";
            portable = "📱";
            car = "🚗";
            default = ["🔈" "🔉" "🔊"];
          };
          on-click = "pavucontrol";
        };

        "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "🔒";
            unlocked = "🔓";
          };
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        font-weight: bold;
        min-height: 0;
      }

      window#waybar {
        background: rgba(21, 18, 27, 0.8);
        color: #cdd6f4;
      }

      #workspaces {
        background: #1e1e2e;
        margin: 5px;
        padding: 0px 5px 0px 5px;
        border-radius: 9px;
        border: 0px;
        font-style: normal;
      }

      #workspaces button {
        padding: 0px 5px;
        margin: 5px 0px;
        border-radius: 9px;
        color: #cdd6f4;
        background: transparent;
        font-style: normal;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
        box-shadow: inherit;
        text-shadow: inherit;
        border-radius: 9px;
      }

      #workspaces button.active {
        background: #89b4fa;
        color: #1e1e2e;
        border-radius: 9px;
      }

      #workspaces button.urgent {
        background: #f38ba8;
        color: #1e1e2e;
        border-radius: 9px;
      }

      #window {
        background: #1e1e2e;
        margin: 5px;
        padding: 0px 5px 0px 5px;
        border-radius: 9px;
        color: #cdd6f4;
      }

      #taskbar {
        background: #1e1e2e;
        margin: 5px;
        padding: 0px 5px 0px 5px;
        border-radius: 9px;
      }

      #taskbar button {
        padding: 0px 5px;
        margin: 5px 0px;
        border-radius: 9px;
        color: #cdd6f4;
      }

      #taskbar button:hover {
        background: rgba(0, 0, 0, 0.2);
        box-shadow: inherit;
        text-shadow: inherit;
        border-radius: 9px;
      }

      #taskbar button.active {
        background: #89b4fa;
        color: #1e1e2e;
        border-radius: 9px;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #tray,
      #backlight,
      #keyboard-state {
        background: #1e1e2e;
        padding: 0px 10px;
        margin: 5px 0px;
        color: #cdd6f4;
      }

      #clock {
        color: #89b4fa;
        border-radius: 9px 0px 0px 9px;
      }

      #battery {
        color: #a6e3a1;
      }

      #battery.charging {
        color: #a6e3a1;
      }

      #battery.warning:not(.charging) {
        color: #f38ba8;
      }

      #cpu {
        color: #f9e2af;
      }

      #memory {
        color: #cba6f7;
      }

      #temperature {
        color: #fab387;
      }

      #temperature.critical {
        color: #f38ba8;
      }

      #network {
        color: #89b4fa;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #pulseaudio {
        color: #89b4fa;
        border-radius: 0px 9px 9px 0px;
      }

      #pulseaudio.muted {
        color: #f38ba8;
      }

      #tray {
        margin-right: 5px;
        border-radius: 9px;
      }

      #keyboard-state {
        color: #89b4fa;
      }

      #keyboard-state label.locked {
        color: #f38ba8;
      }
    '';
  };
} 