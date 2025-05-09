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

    # Development tools
    git
    neovim

    # Fonts
    nerd-fonts.jetbrainsmono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

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
