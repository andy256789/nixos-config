{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.gtk;
  theme = config.themes;
in {
  options.modules.gtk = {
    enable = mkEnableOption "Enable GTK configuration";
    
    iconTheme = mkOption {
      type = types.str;
      default = "Papirus-Dark";
      description = "Icon theme name";
    };
    
    cursorTheme = mkOption {
      type = types.str;
      default = "Breeze";
      description = "Cursor theme name";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome-themes-extra
      papirus-icon-theme
      adwaita-qt
      breeze-icons
      breeze-gtk
      gnome.adwaita-icon-theme
      whitesur-gtk-theme
      # Font dependencies
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
    ];

    gtk = {
      enable = true;
      theme = {
        name = "WhiteSur-Dark";
        package = pkgs.whitesur-gtk-theme;
      };
      iconTheme = {
        name = cfg.iconTheme;
        package = pkgs.papirus-icon-theme;
      };
      cursorTheme = {
        name = cfg.cursorTheme;
        package = pkgs.breeze-cursors;
        size = 24;
      };
      font = {
        name = theme.fonts.sansSerif;
        size = theme.fonts.size.normal;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-button-images = true;
        gtk-menu-images = true;
        gtk-cursor-theme-size = 24;
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-cursor-theme-size = 24;
      };
    };

    qt = {
      enable = true;
      platformTheme = {
        name = "gtk";
      };
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    # Configure XDG settings to make everything consistent
    xdg = {
      mime.enable = true;
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
      };
    };

    # Add font configuration
    fonts.fontconfig.enable = true;
    
    # Set cursor for Wayland and X11
    home.pointerCursor = {
      name = cfg.cursorTheme;
      package = pkgs.breeze-cursors;
      size = 24;
      x11.enable = true;
      gtk.enable = true;
    };
  };
} 