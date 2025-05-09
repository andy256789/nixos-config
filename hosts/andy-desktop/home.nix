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
      viAlias = true;
      vimAlias = true;
    };
    ghostty = {
      enable = true;
      settings = {
        font = "Maple Mono";
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
        timeouts = true;
        time-format = "%H:%M";
        short-time = true;
        show-dnd-toggle = true;
        show-control-center = true;
        show-notifications = true;
        show-incoming-calls = true;
        show-outgoing-calls = true;
        show-music-control = true;
        show-dnd-indicator = true;
        show-media = true;
        show-battery = true;
        show-battery-percentage = true;
        show-battery-time = true;
        show-battery-icon = true;
        show-battery-status = true;
        show-battery-status-charging = true;
        show-battery-status-discharging = true;
        show-battery-status-full = true;
        show-battery-status-low = true;
        show-battery-status-critical = true;
        show-battery-status-unknown = true;
        show-battery-status-empty = true;
        show-battery-status-charged = true;
        show-battery-status-charging-symbol = true;
        show-battery-status-discharging-symbol = true;
        show-battery-status-full-symbol = true;
        show-battery-status-low-symbol = true;
        show-battery-status-critical-symbol = true;
        show-battery-status-unknown-symbol = true;
        show-battery-status-empty-symbol = true;
        show-battery-status-charged-symbol = true;
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
