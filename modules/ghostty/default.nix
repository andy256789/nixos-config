{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.ghostty;
    theme = config.themes;
in {
    options.modules.ghostty = {
        enable = mkEnableOption "Enable ghostty terminal";

    };

    config = mkIf cfg.enable {
        programs.ghostty = {
            enable = true;
            settings = {
                # Font settings
                "font-family" = theme.fonts.monospace;
                "font-size" = 12;

                # Window settings
                "window-padding-x" = 10;
                "window-padding-y" = 10;
                "background-opacity" = toString theme.opacity.terminal;

                # Cursor settings
                "cursor-style" = "bar";
                "cursor-style-blink" = true;

                # System integration
                "macos-option-as-alt" = true;

                # Color theme
                "foreground" = theme.colors.foreground;
                "background" = theme.colors.background;
                "cursor-color" = theme.colors.accent.primary;
                "selection-background" = theme.colors.accent.tertiary;
                "selection-foreground" = theme.colors.background;

            };
        };
    };
} 
