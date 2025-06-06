{ config, pkgs, inputs, ... }:

{
    imports = [
        ../../modules
        inputs.nixvim.homeManagerModules.nixvim
    ];

    home.stateVersion = "24.11";

    # Enable themes with default settings
    themes.enable = true;

    # Enable programs
    programs = {
        fish.enable = true;
    };

    # Enable services
    services = {
        network-manager-applet.enable = true;
    };

    # Enable modules with customizations
    modules = {
        hyprland = {
            enable = true;
            terminal = "ghostty";
            browser = "firefox";
            fileManager = "nemo";
        };

        waybar.enable = true;

        wofi.enable = true;

        gtk = {
            enable = true;
            iconTheme = "Papirus-Dark";
            cursorTheme = "Bibata-Modern-Ice";
        };

        wallpapers = {
            enable = true;
            wallpaper = "anime-cool.png";
        };

        packages = {
            enable = true;
            terminal.enable = true;
            fileManagers.enable = true;
            development.enable = true;
            browsers.enable = true;
            media.enable = true;
            utilities.enable = true;
            communication.enable = true;
        };

        ghostty = {
            enable = true;
            fontSize = 12;
            paddingX = 10;
            paddingY = 10;
            cursorStyle = "bar";
        };

        swaync = {
            enable = true;
            position = {
                x = "right";
                y = "top";
            };
            timeout = {
                default = 10;
                low = 5;
                critical = 0;
            };
            margin = 10;
            iconSize = 64;
        };

        nixvim.enable = true;
        
        yazi = {
            enable = true;
            theme = "tokyonight";
            transparency = 0.9;
        };
        
    };
}
