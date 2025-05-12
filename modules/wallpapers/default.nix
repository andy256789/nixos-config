{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.wallpapers;
in {
  options.modules.wallpapers = {
    enable = mkEnableOption "Enable wallpaper management";
    
    wallpaper = mkOption {
      type = types.str;
      description = "Path to wallpaper image";
      default = "anime-cool.png";
    };
    
    transition = mkOption {
      type = types.str;
      default = "fade";
      description = "Transition effect when changing wallpaper";
    };
    
    transitionStep = mkOption {
      type = types.int;
      default = 90;
      description = "Step value for transition (higher is faster)";
    };
    
    transitionDuration = mkOption {
      type = types.int;
      default = 3;
      description = "Duration of transition in seconds";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swww
    ];
    
    # Copy wallpapers to home directory
    home.file."wallpapers" = {
      source = ./images;
      recursive = true;
    };
    
    # Create script to set wallpaper
    home.file.".local/bin/set-wallpaper" = {
      executable = true;
      text = ''
        #!/bin/sh
        
        # Initialize swww if not running
        if ! pgrep -x swww-daemon > /dev/null; then
          swww-daemon
          sleep 1
        fi
        
        # Apply wallpaper with specified settings
        swww img ${config.home.homeDirectory}/wallpapers/${cfg.wallpaper} \
          --transition-type ${cfg.transition} \
          --transition-step ${toString cfg.transitionStep} \
          --transition-duration ${toString cfg.transitionDuration}
      '';
    };
  };
} 