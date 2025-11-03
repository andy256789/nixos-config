{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.rofi;
    theme = config.themes;
in {
    options.modules.rofi = {
        enable = mkEnableOption "Enable rofi";
    };

    config = mkIf cfg.enable {
        programs.rofi = {
            enable = true;
            package = pkgs.rofi-wayland;
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
    };
}
