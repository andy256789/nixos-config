{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.wallpapers;
in {
  imports = [
    ./catppuccin.nix
  ];
  
  options.modules.wallpapers = {
    enable = mkEnableOption "Enable wallpaper management";
    
    wallpaper = mkOption {
      type = types.path;
      description = "Path to wallpaper image";
      example = "./wallpapers/my-wallpaper.png";
      default = "${config.home.homeDirectory}/wallpapers/catppuccin/cat-lavender.png";
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
    
    # Create script to set wallpaper
    home.file.".local/bin/set-wallpaper" = {
      executable = true;
      text = ''
        #!/bin/sh
        
        # Initialize swww if not running
        if ! pgrep -x swww-daemon > /dev/null; then
          swww init
          sleep 1
        fi
        
        # Apply wallpaper with specified settings
        swww img ${cfg.wallpaper} \
          --transition-type ${cfg.transition} \
          --transition-step ${toString cfg.transitionStep} \
          --transition-duration ${toString cfg.transitionDuration}
      '';
    };
  };
} 