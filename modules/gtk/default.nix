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
            default = "Bibata-Modern-Ice";
            description = "Cursor theme name";
        };
    };

    config = mkIf cfg.enable {
        home.packages = with pkgs; [
            #Theme dependencies
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
            
            # Add CSS to fix color parsing issues
            gtk3.extraCss = ''
                /* Fix any color parsing issues */
                * {
                    outline-color: rgba(255, 255, 255, 0.3);
                    outline-style: dashed;
                    outline-offset: -3px;
                    outline-width: 1px;
                    -gtk-outline-radius: 2px;
                }
            '';
            
            gtk4.extraCss = ''
                /* Ensure proper color handling in GTK4 */
                * {
                    outline: 1px dashed rgba(255, 255, 255, 0.3);
                    outline-offset: -3px;
                }
            '';
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
            package = pkgs.bibata-cursors;
            size = 24;
            x11.enable = true;
            gtk.enable = true;
        };
    };
} 
