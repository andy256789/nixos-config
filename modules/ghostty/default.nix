{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.ghostty;
  theme = config.themes;
in {
  options.modules.ghostty = {
    enable = mkEnableOption "Enable ghostty terminal";
    
    fontSize = mkOption {
      type = types.int;
      default = 12;
      description = "Font size for ghostty";
    };
    
    paddingX = mkOption {
      type = types.int;
      default = 10;
      description = "Horizontal padding";
    };
    
    paddingY = mkOption {
      type = types.int;
      default = 10;
      description = "Vertical padding";
    };
    
    cursorStyle = mkOption {
      type = types.enum [ "block" "beam" "underline" ];
      default = "beam";
      description = "Cursor style";
    };
    
    extraSettings = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "Additional ghostty settings";
    };
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        # Font settings
        "font-family" = theme.fonts.monospace;
        "font-size" = cfg.fontSize;
        
        # Window settings
        "window-padding-x" = cfg.paddingX;
        "window-padding-y" = cfg.paddingY;
        "background-opacity" = toString theme.opacity.terminal;
        
        # Cursor settings
        "cursor-style" = cfg.cursorStyle;
        "cursor-style-blink" = true;
        
        # System integration
        "macos-option-as-alt" = true;
        
        # Color theme
        "foreground" = theme.colors.foreground;
        "background" = theme.colors.background;
        "cursor-color" = theme.colors.accent.primary;
        "selection-background" = theme.colors.accent.tertiary;
        "selection-foreground" = theme.colors.background;
        
        # Tab bar
        "tab-bar-show-new-tab-button" = true;
        "tab-bar-show-close-button" = true;
      } // cfg.extraSettings;
    };
  };
} 