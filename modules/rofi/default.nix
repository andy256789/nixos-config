{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.rofi;
    theme = config.themes;
    
    powermenu = pkgs.writeShellScriptBin "rofi-powermenu" ''
        red='#cc241d'
        green='#98971a'
        blue='#458588'
        yellow='#d79921'
        gray='#a89984'

        shutdown="<span color='$red'>󰐥</span>"
        reboot="<span color='$green'>󰜉</span>"
        lock="<span color='$blue'>󰌾</span>"
        suspend="<span color='$yellow'>󰤄</span>"
        quit="<span color='$gray'>✘</span>"

        yes="<span color='$green'>✔</span>"
        no="<span color='$red'>✘</span>"

        theme="$HOME/.config/rofi/powermenu-theme.rasi"

        rofi_cmd() {
            ${pkgs.rofi}/bin/rofi -dmenu -theme $theme -markup-rows
        }

        run_rofi() {
            echo -e "$shutdown\n$reboot\n$lock\n$suspend\n$quit" | rofi_cmd
        }

        confirm_cmd() {
            ${pkgs.rofi}/bin/rofi -theme-str 'window {width: 200px;}' \
                -theme-str 'listview { columns: 2; }' \
                -dmenu -theme $theme -markup-rows
        }

        rofi_confirm() {
            echo -e "$yes"
        }

        run_cmd() {
            selected="$(rofi_confirm)"
            if [[ "$selected" == "$yes" ]]; then
                if [[ $1 == '--shutdown' ]]; then
                    systemctl poweroff
                elif [[ $1 == '--reboot' ]]; then
                    systemctl reboot
                elif [[ $1 == '--suspend' ]]; then
                    ${pkgs.hyprlock}/bin/hyprlock &
                    systemctl suspend
                fi
            else
                exit 0
            fi
        }

        chosen="$(run_rofi)"
        case ''${chosen} in
            $shutdown)
                run_cmd --shutdown
                ;;
            $reboot)
                run_cmd --reboot
                ;;
            $lock)
                sleep 0.1
                ${pkgs.hyprlock}/bin/hyprlock
                ;;
            $suspend)
                sleep 0.1
                run_cmd --suspend
                ;;
        esac
    '';
in {
    options.modules.rofi = {
        enable = mkEnableOption "Enable rofi";
    };

    config = mkIf cfg.enable {
        home.packages = [ powermenu ];
        programs.rofi = {
            enable = true;
            package = pkgs.rofi;
            terminal = "${pkgs.ghostty}/bin/ghostty";
            
            extraConfig = {
                modi = "drun,run,window";
                show-icons = true;
                drun-display-format = "{name}";
                location = 0;
                disable-history = false;
                hide-scrollbar = true;
                display-drun = "   Apps ";
                display-run = "   Run ";
                display-window = " 﩯  Window";
                display-Network = " 󰤨  Network";
                sidebar-mode = true;
            };

            theme = 
                let 
                    inherit (config.lib.formats.rasi) mkLiteral;
                in {
                    "*" = {
                        bg-col = mkLiteral theme.colors.background;
                        bg-col-light = mkLiteral theme.colors.background;
                        border-col = mkLiteral theme.colors.accent.primary;
                        selected-col = mkLiteral theme.colors.background;
                        blue = mkLiteral theme.colors.accent.primary;
                        fg-col = mkLiteral theme.colors.foreground;
                        fg-col2 = mkLiteral theme.colors.accent.secondary;
                        grey = mkLiteral "${theme.utils.hexToRgba theme.colors.foreground 0.5}";
                        width = 600;
                    };

                    "element-text, element-icon , mode-switcher" = {
                        background-color = mkLiteral "inherit";
                        text-color = mkLiteral "inherit";
                    };

                    "window" = {
                        height = 380;
                        border = mkLiteral "2px";
                        border-color = mkLiteral "@border-col";
                        background-color = mkLiteral "@bg-col";
                        border-radius = mkLiteral "${toString theme.border.radius}px";
                    };

                    "mainbox" = {
                        background-color = mkLiteral "@bg-col";
                    };

                    "inputbar" = {
                        children = mkLiteral "[prompt,entry]";
                        background-color = mkLiteral "@bg-col";
                        border-radius = mkLiteral "${toString theme.border.radius}px";
                        padding = mkLiteral "2px";
                        margin = mkLiteral "10px";
                    };

                    "prompt" = {
                        background-color = mkLiteral "@blue";
                        padding = mkLiteral "10px";
                        text-color = mkLiteral "@bg-col";
                        border-radius = mkLiteral "${toString theme.border.radius}px";
                        margin = mkLiteral "5px 0px 0px 5px";
                    };

                    "textbox-prompt-colon" = {
                        expand = false;
                        str = ":";
                    };

                    "entry" = {
                        padding = mkLiteral "10px";
                        margin = mkLiteral "5px 5px 5px 10px";
                        text-color = mkLiteral "@fg-col";
                        background-color = mkLiteral "@bg-col";
                    };

                    "listview" = {
                        border = mkLiteral "0px 0px 0px";
                        padding = mkLiteral "6px 0px 0px";
                        margin = mkLiteral "10px 10px 0px 10px";
                        columns = 1;
                        lines = 8;
                        background-color = mkLiteral "@bg-col";
                    };

                    "element" = {
                        padding = mkLiteral "8px";
                        margin = mkLiteral "5px";
                        background-color = mkLiteral "@bg-col";
                        text-color = mkLiteral "@fg-col";
                        border-radius = mkLiteral "${toString theme.border.radius}px";
                    };

                    "element-icon" = {
                        size = mkLiteral "28px";
                    };

                    "element selected" = {
                        background-color = mkLiteral "@blue";
                        text-color = mkLiteral "@bg-col";
                    };

                    "mode-switcher" = {
                        spacing = 0;
                    };

                    "button" = {
                        padding = mkLiteral "10px";
                        background-color = mkLiteral "@bg-col-light";
                        text-color = mkLiteral "@grey";
                        vertical-align = mkLiteral "0.5";
                        horizontal-align = mkLiteral "0.5";
                    };

                    "button selected" = {
                        background-color = mkLiteral "@bg-col";
                        text-color = mkLiteral "@blue";
                    };

                    "message" = {
                        background-color = mkLiteral "@bg-col-light";
                        margin = mkLiteral "2px";
                        padding = mkLiteral "2px";
                        border-radius = mkLiteral "${toString theme.border.radius}px";
                    };

                    "textbox" = {
                        padding = mkLiteral "6px";
                        margin = mkLiteral "20px 0px 0px 20px";
                        text-color = mkLiteral "@blue";
                        background-color = mkLiteral "@bg-col-light";
                    };
                };
        };

        # Power menu theme
        home.file.".config/rofi/powermenu-theme.rasi".text = ''
            * {
                bg-col: ${theme.colors.background};
                bg-col-transparent: ${theme.utils.hexToRgba theme.colors.background 0.95};
                border-col: ${theme.colors.accent.primary};
                selected-col: ${theme.colors.accent.primary};
                fg-col: ${theme.colors.foreground};
                urgent: #cc241d;
                background-color: transparent;
                text-color: @fg-col;
                font: "JetBrainsMono Nerd Font 12";
            }

            window {
                transparency: "real";
                location: center;
                anchor: center;
                fullscreen: false;
                width: 600px;
                height: 180px;
                background-color: @bg-col-transparent;
                border: 2px solid;
                border-color: @border-col;
                border-radius: ${toString theme.border.radius}px;
            }

            mainbox {
                enabled: true;
                spacing: 0px;
                background-color: transparent;
                children: [ "listview" ];
            }

            listview {
                enabled: true;
                columns: 5;
                lines: 1;
                cycle: true;
                dynamic: true;
                scrollbar: false;
                layout: vertical;
                reverse: false;
                fixed-height: true;
                fixed-columns: true;
                spacing: 15px;
                margin: 30px;
                background-color: transparent;
            }

            element {
                enabled: true;
                padding: 25px 10px;
                background-color: ${theme.utils.hexToRgba theme.colors.background 0.3};
                text-color: @fg-col;
                border-radius: ${toString theme.border.radius}px;
                cursor: pointer;
            }

            element-text {
                font: "JetBrainsMono Nerd Font 32";
                background-color: transparent;
                text-color: inherit;
                cursor: inherit;
                vertical-align: 0.5;
                horizontal-align: 0.5;
            }

            element selected.normal {
                background-color: @selected-col;
                text-color: @bg-col;
                background-image: linear-gradient(${theme.colors.accent.primary}, ${theme.colors.accent.tertiary});
                border-radius: ${toString theme.border.radius}px;
            }

            element.urgent {
                background-color: @urgent;
            }
        '';
    };
}
