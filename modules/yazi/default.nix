{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.yazi;
  theme = config.themes;
in {
  options.modules.yazi = {
    enable = mkEnableOption "Enable yazi file manager";

    theme = mkOption {
      type = types.str;
      default = "tokyonight";
      description = "Theme for yazi";
    };

    vimBindings = mkOption {
      type = types.bool;
      default = false;
      description = "Enable vim keybindings";
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
          edit = [
            { exec = "nvim \"$@\""; }
          ];
          
          open = [
            { exec = "xdg-open \"$@\""; }
          ];
          
          reveal = [
            { exec = "exiftool \"$1\"; echo \"Press enter to exit\"; read"; orphan = true; }
          ];
        };

        open = {
          rules = [
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
      };

      keymap = mkIf cfg.vimBindings {
        manager.prepend_keymap = [
          # Vim-style navigation
          { on = ["h"]; run = "leave"; }
          { on = ["j"]; run = "cursor_move_down"; }
          { on = ["k"]; run = "cursor_move_up"; }
          { on = ["l"]; run = "enter"; }
          { on = ["g", "g"]; run = "cursor_move_home"; }
          { on = ["G"]; run = "cursor_move_end"; }
          { on = ["H"]; run = "cd .."; }
          { on = ["L"]; run = "open"; }
          
          # Vim-style yanking (copying)
          { on = ["y", "y"]; run = "copy_filename"; }
          { on = ["Y"]; run = "copy_filepath"; }
          
          # Vim-style visual mode
          { on = ["v"]; run = "select --state=visual"; }
          { on = ["V"]; run = "select_all --state=visual"; }
          
          # Common vim operations
          { on = ["d", "d"]; run = "remove"; }
          { on = ["p"]; run = "paste"; }
          { on = ["u"]; run = "undo"; }
          { on = ["Ctrl+r"]; run = "redo"; }
          
          # Search
          { on = ["/"]; run = "search"; }
          { on = ["n"]; run = "search_next"; }
          { on = ["N"]; run = "search_prev"; }
          
          # Quick navigation
          { on = ["~"]; run = "cd ~"; }
          { on = ["\\"]; run = "cd /"; }
        ];
      };

      theme = {
        color = if cfg.theme == "tokyonight" then {
          # Based on Tokyo Night theme
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
        } else {};
        
        ui = {
          default = { fg = "white"; bg = { rgba = "black ${toString cfg.transparency}"; }; };
          
          # Selection
          selection = { fg = "black"; bg = "blue"; };
          selected_line = { fg = null; bg = "bright_black"; bold = true; };
          
          # Borders
          border = { fg = "bright_black"; bg = { rgba = "black ${toString cfg.transparency}"; }; };
          
          # Status
          statusline = { fg = "white"; bg = { rgba = "bright_black ${toString cfg.transparency}"; }; };
          statusline_file = { fg = "cyan"; bg = { rgba = "bright_black ${toString cfg.transparency}"; }; bold = true; };
          statusline_directory = { fg = "blue"; bg = { rgba = "bright_black ${toString cfg.transparency}"; }; bold = true; };
          
          # Headers
          title = { fg = "blue"; bg = null; bold = true; };
          
          # Panels
          filetype = {
            dir = { fg = "blue"; bg = null; bold = true; };
            file = { fg = "white"; bg = null; };
            symlink = { fg = "cyan"; bg = null; italic = true; };
            pipe = { fg = "yellow"; bg = null; };
            socket = { fg = "magenta"; bg = null; };
            executable = { fg = "green"; bg = null; bold = true; };
            
            # Default for other types
            ".*" = { fg = "white"; bg = null; };
          };
        };
      };
    };
  };
} 