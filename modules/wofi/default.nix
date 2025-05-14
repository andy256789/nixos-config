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
                width = 480;
                height = 380;
                location = "center";
                show = "drun";
                prompt = "";
                filter_rate = 100;
                allow_markup = true;
                no_actions = true;
                halign = "fill";
                orientation = "vertical";
                content_halign = "fill";
                insensitive = true;
                allow_images = true;
                image_size = 28;
                gtk_dark = true;
                dynamic_lines = true;
            };
            
            style = ''
                @define-color bg-color #{rgba(30, 30, 46, ${toString theme.opacity.panel})};
                @define-color fg-color #{${theme.colors.foreground}};
                @define-color base-color #{rgba(30, 30, 46, 0.7)};
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
                    border: 2px solid rgba(137, 180, 250, 0.8);
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                }

                #input {
                    padding: 10px 15px;
                    margin: 15px;
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
                    box-shadow: 0 0 0 2px rgba(137, 180, 250, 0.3);
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
                    padding: 8px 12px;
                    margin: 3px 15px;
                    border-radius: ${toString theme.border.radius}px;
                    background-color: transparent;
                    transition: all 0.2s ease;
                }

                #entry:selected {
                    background: linear-gradient(90deg, rgba(137, 180, 250, 0.9), rgba(203, 166, 247, 0.7));
                    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
                }

                #entry:selected #text {
                    color: ${theme.colors.background};
                    font-weight: bold;
                }

                #img {
                    margin-right: 10px;
                    margin-left: 5px;
                }
            '';
        };
    };
} 
