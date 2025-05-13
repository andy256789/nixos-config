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
    };

    config = mkIf cfg.enable {
        home.packages = with pkgs; [ swww ];

        home.file."wallpapers" = { source = ./images; recursive = true; };
    };
} 
