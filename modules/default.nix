{ config, lib, pkgs, ... }:

{
    imports = [
        ./themes
        ./waybar
        ./hyprland
        ./gtk
        ./packages
        ./ghostty
        ./swaync
        ./wallpapers
        ./nixvim
        ./yazi
        ./rofi
        ./hyprlock
        ./cybersecurity
    ];
} 
