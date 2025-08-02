{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.gtk;
  theme = config.themes;
  
  # Define common values to avoid repetition
  cursorSize = 24;
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
      default = "Bibata-Modern-Ice";
      description = "Cursor theme name";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Theme dependencies
      gnome-themes-extra
      papirus-icon-theme
      adwaita-qt
      materia-theme
      adwaita-icon-theme
      bibata-cursors
      
      # Font dependencies
      noto-fonts
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
    ];

    # GTK configuration
    gtk = {
      enable = true;
      
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      
      iconTheme = {
        name = cfg.iconTheme;
        package = pkgs.papirus-icon-theme;
      };
      
      cursorTheme = {
        name = cfg.cursorTheme;
        package = pkgs.bibata-cursors;
        size = cursorSize;
      };
      
      font = {
        name = theme.fonts.sansSerif;
        size = theme.fonts.size.normal;
      };
      
      # GTK3 specific configuration
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-button-images = true;
        gtk-menu-images = true;
        gtk-cursor-theme-size = cursorSize;
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      };
      
      # GTK4 specific configuration
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
        gtk-cursor-theme-size = cursorSize;
      };
    };

    # Qt configuration for theme consistency
    qt = {
      enable = true;
      platformTheme.name = "gtk";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    # XDG portal configuration
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

    # Font configuration
    fonts.fontconfig.enable = true;

    # Cursor configuration for both Wayland and X11
    home.pointerCursor = {
      name = cfg.cursorTheme;
      package = pkgs.bibata-cursors;
      size = cursorSize;
      x11.enable = true;
      gtk.enable = true;
    };
  };
} 
