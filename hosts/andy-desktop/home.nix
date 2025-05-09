{ config, pkgs, inputs, username, ... }:

{
  imports = [
    ../../modules/hyprland.nix
    ../../modules/waybar.nix
    ../../modules/packages.nix
    ../../modules/gtk.nix
  ];

  home.stateVersion = "24.11";

  # Enable programs
  programs = {
    fish.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    ghostty = {
      enable = true;
      settings = {
        font = "JetBrains Mono";
        font-size = 12;
        background-opacity = 0.8;
        padding = 8;
      };
    };
  };

  # Enable services
  services = {
    network-manager-applet.enable = true;
    swaync = {
      enable = true;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        control-center-layer = "overlay";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 10;
        control-center-margin-bottom = 10;
        control-center-margin-right = 10;
        control-center-margin-left = 10;
        notification-icon-size = 64;
        notification-body-image-height = 100;
        notification-body-image-width = 200;
        timeout = 10;
        timeout-low = 5;
        timeout-critical = 0;
        fit-to-screen = true;
        relative-timestamps = true;
        show-timeout = true;
      };
    };
  };

  # XDG portal configuration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
