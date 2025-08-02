{ config, pkgs, inputs, settings, ... }:

{
    imports = [
        ../../modules
        inputs.nixvim.homeManagerModules.nixvim
    ];

    home = {
        username = settings.username;
        homeDirectory = "/home/${settings.username}";
        stateVersion = "25.05";
    };

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

        cybersecurity.enable = true;

        gtk = {
            enable = true;
            iconTheme = "Papirus-Dark";
            cursorTheme = "Bibata-Modern-Ice";
        };

        wallpapers = {
            enable = true;
            wallpaper = "anime-black-hole.png";
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

        ghostty.enable = true;

        swaync.enable = true;

        nixvim.enable = true;
        
        yazi.enable = true;

    };
}
