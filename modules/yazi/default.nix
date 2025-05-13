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
          sort_sensitive = false;
          sort_reverse = false;
          sort_dir_first = true;
          linemode = "size";
          show_hidden = false;
          show_symlink = true;
        };

        preview = {
          tab_size = 2;
          max_width = 1000;
          max_height = 1000;
          cache_dir = "~/.cache/yazi";
        };

        opener = {
          edit = [{ exec = "nvim \"$@\""; }];
          open = [{ exec = "xdg-open \"$@\""; }];
          reveal = [{ exec = "exiftool \"$1\"; echo \"Press enter to exit\"; read"; orphan = true; }];
        };

        open.rules = [
          { name = "*/"; use = "editor"; }
          { mime = "text/*"; use = "editor"; }
          { mime = "image/*"; use = "open"; }
          { mime = "video/*"; use = "open"; }
          { mime = "audio/*"; use = "open"; }
          { mime = "application/pdf"; use = "open"; }
          { mime = "application/json"; use = "editor"; }
          { mime = "*/javascript"; use = "editor"; }
          { mime = "*/x-wine-extension-ini"; use = "editor"; }
        ];
      };

      # Tokyo Night theme with transparency
      theme = {
        color = {
          # Tokyo Night theme colors
          black = "#15161e";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
          bright_black = "#414868";
          bright_red = "#f7768e";
          bright_green = "#9ece6a";
          bright_yellow = "#e0af68";
          bright_blue = "#7aa2f7";
          bright_magenta = "#bb9af7";
          bright_cyan = "#7dcfff";
          bright_white = "#c0caf5";
        };
        
        ui = {
          default = { fg = "white"; bg = { rgba = "black ${toString cfg.transparency}"; }; };
          
          # Selection
          selection = { fg = "black"; bg = "blue"; };
          selected_line = { bg = "bright_black"; bold = true; };
          
          # Borders
          border = { fg = "bright_black"; bg = { rgba = "black ${toString cfg.transparency}"; }; };
          
          # Status
          statusline = { fg = "white"; bg = { rgba = "bright_black ${toString cfg.transparency}"; }; };
          statusline_file = { fg = "cyan"; bg = { rgba = "bright_black ${toString cfg.transparency}"; }; bold = true; };
          statusline_directory = { fg = "blue"; bg = { rgba = "bright_black ${toString cfg.transparency}"; }; bold = true; };
          
          # Headers
          title = { fg = "blue"; bold = true; };
          
          # Panels
          filetype = {
            dir = { fg = "blue"; bold = true; };
            file = { fg = "white"; };
            symlink = { fg = "cyan"; italic = true; };
            pipe = { fg = "yellow"; };
            socket = { fg = "magenta"; };
            executable = { fg = "green"; bold = true; };
            
            # Default for other types
            ".*" = { fg = "white"; };
          };
        };
      };
    };
  };
} 