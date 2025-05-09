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
    maple-mono

    # GTK theme and icons
    adwaita-qt
    gnome.adwaita-icon-theme
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