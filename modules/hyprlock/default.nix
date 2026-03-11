{ config, lib, ... }:

with lib;

let
    cfg = config.modules.hyprlock;
    theme = config.themes;
in {
    options.modules.hyprlock = {
        enable = mkEnableOption "Enable hyprlock";
    };

    config = mkIf cfg.enable {
        programs.hyprlock = {
            enable = true;
            
            settings = {
                general = {
                    disable_loading_bar = true;
                    grace = 0;
                    hide_cursor = true;
                    no_fade_in = false;
                };

                background = [
                    {
                        path = "screenshot";
                        blur_passes = 3;
                        blur_size = 8;
                    }
                ];

                input-field = [
                    {
                        size = "200, 50";
                        position = "0, -80";
                        monitor = "";
                        dots_center = true;
                        fade_on_empty = false;
                        font_color = "rgb(${builtins.substring 1 6 theme.colors.foreground})";
                        inner_color = "rgb(${builtins.substring 1 6 theme.colors.background})";
                        outer_color = "rgb(${builtins.substring 1 6 theme.colors.accent.primary})";
                        outline_thickness = 2;
                        placeholder_text = ''<span foreground="##${builtins.substring 1 6 theme.colors.foreground}">Password...</span>'';
                        shadow_passes = 2;
                    }
                ];

                label = [
                    {
                        monitor = "";
                        text = "cmd[update:1000] echo \"<b><big> $(date +\"%H:%M\") </big></b>\"";
                        color = "rgb(${builtins.substring 1 6 theme.colors.foreground})";
                        font_size = 64;
                        font_family = theme.fonts.monospace;
                        position = "0, 16";
                        halign = "center";
                        valign = "center";
                    }
                    {
                        monitor = "";
                        text = "cmd[update:43200000] echo \"<b> $(date +\"%A, %d %B %Y\") </b>\"";
                        color = "rgb(${builtins.substring 1 6 theme.colors.foreground})";
                        font_size = 24;
                        font_family = theme.fonts.monospace;
                        position = "0, -16";
                        halign = "center";
                        valign = "center";
                    }
                ];
            };
        };
    };
}
