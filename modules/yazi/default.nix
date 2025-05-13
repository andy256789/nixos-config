{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.yazi;
in {
  options.modules.yazi = {
    enable = mkEnableOption "Enable yazi file manager";

    theme = mkOption {
      type = types.str;
      default = "tokyonight";
      description = "Theme for yazi";
    };

    transparency = mkOption {
      type = types.float;
      default = 1.0;
      description = "Background transparency (0.0-1.0)";
    };
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = config.programs.fish.enable;
      
      settings = {
        manager = {
          layout = [1 3 3];
          sort_by = "alphabetical";
          sort_dir_first = true;
          show_hidden = false;
          show_symlink = true;
        };

        preview = {
          tab_size = 2;
          max_width = 1000;
          max_height = 1000;
        };
      };

      keymap = {
        normal = {
          h = "leave";
          j = "down";
          k = "up";
          l = "enter";
          
          # Common operations
          y = "copy";
          p = "paste";
          d = "cut";
          
          "g" = "goto_top";
          "G" = "goto_bottom";
          
          "/" = "search";
          "n" = "search_next";
          "N" = "search_prev";
        };
      };
    };

    # Add yazi transparency and theme through custom config file
    xdg.configFile."yazi/theme.toml".text = ''
      [colors]
      black = "#15161e"
      red = "#f7768e"
      green = "#9ece6a"
      yellow = "#e0af68"
      blue = "#7aa2f7"
      magenta = "#bb9af7"
      cyan = "#7dcfff"
      white = "#a9b1d6"
      
      [manager]
      fg = "white"
      bg = { rgba = "black ${toString cfg.transparency}" }
      preview_fg = "white"
      preview_bg = { rgba = "black ${toString cfg.transparency}" }
      
      [status]
      fg = "white"
      bg = { rgba = "#414868 ${toString cfg.transparency}" }
      
      [selection]
      fg = "black"
      bg = "blue"
      
      [visual]
      bg = "#414868"
      
      [file]
      directory = { fg = "blue", bold = true }
      executable = { fg = "green", bold = true }
      symlink = { fg = "cyan", italic = true }
    '';
  };
} 