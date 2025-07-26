{ config, lib, pkgs, ... }:

{
    imports = [
        ./themes
        ./prisma
        ./waybar
        ./hyprland
        ./gtk
        ./packages
        ./ghostty
        ./swaync
        ./wallpapers
        ./nixvim
        ./yazi
        ./wofi
    ];
} 
