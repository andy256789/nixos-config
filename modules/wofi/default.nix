{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.wofi;
    theme = config.themes;
in {
    options.modules.wofi = {
        enable = mkEnableOption "Enable wofi";
    };

    config = mkIf cfg.enable {
        programs.wofi = {
            enable = true;
            settings = {
                width = 500;
                height = 400;
                location = "center";
                show = "drun";
                prompt = "Search...";
                filter_rate = 100;
                allow_markup = true;
                no_actions = true;
                halign = "fill";
                orientation = "vertical";
                content_halign = "fill";
                insensitive = true;
                allow_images = true;
                image_size = 24;
                gtk_dark = true;
                dynamic_lines = true;
            };
            
            style = ''
                @define-color bg-color #{rgba(${builtins.substring 1 6 theme.colors.background}, ${toString theme.opacity.panel})};
                @define-color fg-color #{${theme.colors.foreground}};
                @define-color base-color #{rgba(${builtins.substring 1 6 theme.colors.background}, 0.6)};
                @define-color accent-color #{${theme.colors.accent.primary}};
                @define-color secondary-color #{${theme.colors.accent.secondary}};
                @define-color tertiary-color #{${theme.colors.accent.tertiary}};
                @define-color warning-color #{${theme.colors.accent.warning}};
                @define-color error-color #{${theme.colors.accent.error}};

                window {
                    margin: 0;
                    padding: 0;
                    background-color: @bg-color;
                    border-radius: ${toString theme.border.radius}px;
                    border: 2px solid @accent-color;
                }

                #input {
                    padding: 8px 12px;
                    margin: 10px;
                    border-radius: ${toString theme.border.radius}px;
                    border: none;
                    color: @fg-color;
                    background-color: @base-color;
                    font-family: "${theme.fonts.monospace}";
                    font-size: ${toString theme.fonts.size.normal}px;
                }

                #input:focus {
                    border: none;
                    outline: none;
                }

                #inner-box {
                    margin: 10px;
                    background-color: transparent;
                }

                #outer-box {
                    margin: 0;
                    padding: 0;
                    background-color: @bg-color;
                    border-radius: ${toString theme.border.radius}px;
                }

                #scroll {
                    margin: 0;
                    border: none;
                }

                #text {
                    margin: 5px;
                    color: @fg-color;
                    font-family: "${theme.fonts.monospace}";
                    font-size: ${toString theme.fonts.size.normal}px;
                }

                #entry {
                    padding: 8px;
                    margin: 2px 10px;
                    border-radius: ${toString theme.border.radius}px;
                    background-color: transparent;
                }

                #entry:selected {
                    background-color: @accent-color;
                }

                #entry:selected #text {
                    color: @bg-color;
                    font-weight: bold;
                }

                #img {
                    margin-right: 10px;
                }
            '';
        };
    };
} 