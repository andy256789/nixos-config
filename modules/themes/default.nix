{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.themes;
in {
  options.themes = {
    enable = mkEnableOption "Enable theme settings";
    
    colors = {
      background = mkOption {
        type = types.str;
        default = "#1e1e2e";
        description = "Background color";
      };
      
      foreground = mkOption {
        type = types.str;
        default = "#cdd6f4";
        description = "Foreground color";
      };
      
      accent = {
        primary = mkOption {
          type = types.str;
          default = "#89b4fa";
          description = "Primary accent color";
        };
        
        secondary = mkOption {
          type = types.str;
          default = "#a6e3a1";
          description = "Secondary accent color";
        };
        
        tertiary = mkOption {
          type = types.str;
          default = "#cba6f7";
          description = "Tertiary accent color";
        };
        
        quaternary = mkOption {
          type = types.str;
          default = "#f9e2af";
          description = "Quaternary accent color";
        };
        
        warning = mkOption {
          type = types.str;
          default = "#fab387";
          description = "Warning color";
        };
        
        error = mkOption {
          type = types.str;
          default = "#f38ba8";
          description = "Error color";
        };
      };
    };
    
    fonts = {
      sansSerif = mkOption {
        type = types.str;
        default = "Noto Sans";
        description = "Default sans-serif font";
      };
      
      monospace = mkOption {
        type = types.str;
        default = "JetBrainsMono Nerd Font";
        description = "Default monospace font";
      };
      
      size = {
        small = mkOption {
          type = types.int;
          default = 11;
          description = "Small font size";
        };
        
        normal = mkOption {
          type = types.int;
          default = 13;
          description = "Normal font size";
        };
        
        large = mkOption {
          type = types.int;
          default = 16;
          description = "Large font size";
        };
      };
    };
    
    opacity = {
      panel = mkOption {
        type = types.float;
        default = 0.8;
        description = "Panel opacity";
      };
      
      terminal = mkOption {
        type = types.float;
        default = 0.85;
        description = "Terminal opacity";
      };
    };
    
    border = {
      radius = mkOption {
        type = types.int;
        default = 9;
        description = "Border radius for UI elements";
      };
    };
  };
  
  config = mkIf cfg.enable {
    # No direct configuration - this module just provides options for other modules
  };
} 