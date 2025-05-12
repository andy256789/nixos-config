{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.wallpapers;
in {
  config = mkIf cfg.enable {
    home.file."wallpapers" = {
      source = ./images;
      recursive = true;
    };
    
    # Download Catppuccin wallpapers
    home.activation.downloadCatppuccinWallpapers = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/wallpapers/catppuccin
      if [ ! -f ${config.home.homeDirectory}/wallpapers/catppuccin/cat-mauve.png ]; then
        $DRY_RUN_CMD curl -L -o ${config.home.homeDirectory}/wallpapers/catppuccin/cat-mauve.png https://raw.githubusercontent.com/catppuccin/wallpapers/main/minimalistic/dark-cat-mauve.png
      fi
      if [ ! -f ${config.home.homeDirectory}/wallpapers/catppuccin/cat-lavender.png ]; then
        $DRY_RUN_CMD curl -L -o ${config.home.homeDirectory}/wallpapers/catppuccin/cat-lavender.png https://raw.githubusercontent.com/catppuccin/wallpapers/main/minimalistic/dark-cat-lavender.png
      fi
      if [ ! -f ${config.home.homeDirectory}/wallpapers/catppuccin/cat-blue.png ]; then
        $DRY_RUN_CMD curl -L -o ${config.home.homeDirectory}/wallpapers/catppuccin/cat-blue.png https://raw.githubusercontent.com/catppuccin/wallpapers/main/minimalistic/dark-cat-blue.png
      fi
    '';
  };
} 