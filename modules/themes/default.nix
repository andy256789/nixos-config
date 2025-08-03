{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.themes;
    
    # Helper function to extract RGBA components from hex color
    hexToRgba = color: opacity: 
        let
            # Remove the # prefix
            cleanColor = builtins.substring 1 6 color;
        in
        # For now, we'll use a lookup table for common theme colors
        if cleanColor == "1e1e2e" then "rgba(30, 30, 46, ${toString opacity})"
        else if cleanColor == "89b4fa" then "rgba(137, 180, 250, ${toString opacity})"
        else if cleanColor == "a6e3a1" then "rgba(166, 227, 161, ${toString opacity})"
        else if cleanColor == "cba6f7" then "rgba(203, 166, 247, ${toString opacity})"
        else if cleanColor == "f9e2af" then "rgba(249, 226, 175, ${toString opacity})"
        else if cleanColor == "fab387" then "rgba(250, 179, 135, ${toString opacity})"
        else if cleanColor == "f38ba8" then "rgba(243, 139, 168, ${toString opacity})"
        else if cleanColor == "cdd6f4" then "rgba(205, 214, 244, ${toString opacity})"
        else "rgba(137, 180, 250, ${toString opacity})"; # fallback
        
in {
    options.themes = {
        enable = mkEnableOption "Enable theme settings";

        # Helper utilities for consistent theme usage
        utils = {
            hexToRgba = mkOption {
                type = types.functionTo (types.functionTo types.str);
                default = hexToRgba;
                description = "Function to convert hex color to rgba with opacity";
                readOnly = true;
            };
        };

        colors = {
            background = mkOption {
                type = types.str;
                default = "#1e1e2e";
                description = "Background color";
            };

            foreground = mkOption {
                type = types.str;
                default = "#cdd6f4";
                description = "Foreground color";
            };

            accent = {
                primary = mkOption {
                    type = types.str;
                    default = "#89b4fa";
                    description = "Primary accent color";
                };

                secondary = mkOption {
                    type = types.str;
                    default = "#a6e3a1";
                    description = "Secondary accent color";
                };

                tertiary = mkOption {
                    type = types.str;
                    default = "#cba6f7";
                    description = "Tertiary accent color";
                };

                quaternary = mkOption {
                    type = types.str;
                    default = "#f9e2af";
                    description = "Quaternary accent color";
                };

                warning = mkOption {
                    type = types.str;
                    default = "#fab387";
                    description = "Warning color";
                };

                error = mkOption {
                    type = types.str;
                    default = "#f38ba8";
                    description = "Error color";
                };
            };
        };

        fonts = {
            sansSerif = mkOption {
                type = types.str;
                default = "Noto Sans";
                description = "Default sans-serif font";
            };

            monospace = mkOption {
                type = types.str;
                default = "JetBrainsMono Nerd Font Propo";
                description = "Default monospace font";
            };

            size = {
                small = mkOption {
                    type = types.int;
                    default = 11;
                    description = "Small font size";
                };

                normal = mkOption {
                    type = types.int;
                    default = 13;
                    description = "Normal font size";
                };

                large = mkOption {
                    type = types.int;
                    default = 16;
                    description = "Large font size";
                };
            };
        };

        opacity = {
            panel = mkOption {
                type = types.float;
                default = 0.8;
                description = "Panel opacity";
            };

            terminal = mkOption {
                type = types.float;
                default = 0.85;
                description = "Terminal opacity";
            };
        };

        border = {
            radius = mkOption {
                type = types.int;
                default = 9;
                description = "Border radius for UI elements";
            };
        };
    };

    config = mkIf cfg.enable {
        # No direct configuration - this module just provides options for other modules
    };
} 
