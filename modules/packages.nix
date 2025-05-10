{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal
    ghostty
    foot

    # File managers
    nemo
    yazi

    # System utilities
    networkmanagerapplet
    swaynotificationcenter
    btop
    wofi

    # Development tools
    git

    #Browser
    firefox

    # Fonts
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans

    # GTK theme and icons
    adwaita-qt
    adwaita-icon-theme
    papirus-icon-theme

    # Additional utilities
    wl-clipboard
    cliphist
    grim
    slurp
    swappy
    wf-recorder
    wlogout
    swaylock
    swayidle
  ];
} 
