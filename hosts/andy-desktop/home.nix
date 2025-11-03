{ config, pkgs, inputs, settings, ... }:

{
    imports = [
        ../../modules
        inputs.nixvim.homeModules.nixvim
    ];

    home = {
        username = settings.username;
        homeDirectory = "/home/${settings.username}";
        stateVersion = "25.05";
    };

    # Base configuration
    themes.enable = true;
    programs.fish.enable = true;
    services.network-manager-applet.enable = true;

    # Desktop environment modules
    modules = {
        # Window manager and desktop components
        hyprland = {
            enable = true;
            terminal = "ghostty";
            browser = "firefox";
            fileManager = "nemo";
        };
        waybar.enable = true;
        rofi.enable = true;
        swaync.enable = true;
        hyprlock.enable = true;
        
        # Appearance and theming
        gtk = {
            enable = true;
            iconTheme = "Papirus-Dark";
            cursorTheme = "Bibata-Modern-Ice";
        };
        wallpapers = {
            enable = true;
            wallpaper = "anime-black-hole.png";
        };
        
        # Applications
        ghostty.enable = true;
        nixvim.enable = true;
        yazi.enable = true;
        
        # Package groups
        packages = {
            enable = true;
            development.enable = true;
            browsers.enable = true;
            media.enable = true;
            utilities.enable = true;
            communication.enable = true;
        };
        
        # Special purposes
        cybersecurity.enable = true;

    };
}
