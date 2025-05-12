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
          transition-property: background-color;
          transition-duration: 0.2s;
        }

        window#waybar {
          background: rgba(21, 18, 27, ${toString theme.opacity.panel});
          color: ${theme.colors.foreground};
        }

        #workspaces {
          background: ${theme.colors.background};
          margin: 5px;
          padding: 0px 5px;
          border-radius: ${toString theme.border.radius}px;
          border: 0px;
        }

        #workspaces button {
          padding: 0px 5px;
          margin: 5px 0px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
          background: transparent;
          transition: all 0.2s ease;
        }

        #workspaces button:hover {
          background: rgba(0, 0, 0, 0.2);
          box-shadow: inherit;
          text-shadow: inherit;
        }

        #workspaces button.active {
          background: ${theme.colors.accent.primary};
          color: ${theme.colors.background};
        }

        #workspaces button.urgent {
          background: ${theme.colors.accent.error};
          color: ${theme.colors.background};
        }

        #window {
          background: ${theme.colors.background};
          margin: 5px;
          padding: 0px 10px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #network,
        #pulseaudio,
        #tray,
        #backlight {
          background: ${theme.colors.background};
          padding: 0px 10px;
          margin: 5px 2px;
          border-radius: ${toString theme.border.radius}px;
          color: ${theme.colors.foreground};
        }

        #clock {
          color: ${theme.colors.accent.primary};
          margin-left: 0;
          margin-right: 0;
          font-weight: bold;
        }

        #battery {
          color: ${theme.colors.accent.secondary};
        }

        #battery.charging, #battery.plugged {
          color: ${theme.colors.accent.secondary};
        }

        #battery.warning:not(.charging) {
          color: ${theme.colors.accent.warning};
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

        tooltip {
          background: ${theme.colors.background};
          border: 1px solid ${theme.colors.accent.primary};
          border-radius: ${toString theme.border.radius}px;
        }

        tooltip label {
          color: ${theme.colors.foreground};
        }
      '';
    };
  };
} 