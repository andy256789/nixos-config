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
  ];
} 