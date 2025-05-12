{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.fileExplorer = {
    type = mkOption {
      type = types.enum [ "nvim-tree" "neo-tree" "none" ];
      default = "nvim-tree";
      description = "File explorer plugin to use";
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        nvim-tree = {
          enable = cfg.fileExplorer.type == "nvim-tree";
          disableNetrw = true;
          hijackNetrw = true;
          openOnSetup = false;
          respectBufCwd = true;
          sortBy = "name";
          syncRootWithCwd = true;
          git.enable = true;
          
          view = {
            width = 30;
            side = "left";
          };
          
          renderer = {
            highlightGit = true;
            indentMarkers.enable = true;
            icons = {
              gitPlacement = "after";
              show = {
                file = true;
                folder = true;
                folderArrow = true;
                git = true;
              };
            };
          };
        };
        
        neo-tree = {
          enable = cfg.fileExplorer.type == "neo-tree";
          closeIfLastWindow = true;
          popupBorderStyle = "rounded";
          
          window = {
            width = 30;
            position = "left";
            mappings = {
              "<cr>" = "open";
              "q" = "close_window";
              "v" = "open_vsplit";
              "a" = "add";
              "d" = "delete";
              "r" = "rename";
              "c" = "copy_to_clipboard";
              "x" = "cut_to_clipboard";
              "p" = "paste_from_clipboard";
            };
          };
        };
      };
      
      keymaps = [
        {
          key = "<leader>e";
          action = ":NvimTreeToggle<CR>";
          mode = "n";
          options = { 
            desc = "Toggle file explorer";
            silent = true;
          };
          condition = cfg.fileExplorer.type == "nvim-tree";
        }
        {
          key = "<leader>e";
          action = ":Neotree toggle<CR>";
          mode = "n";
          options = { 
            desc = "Toggle file explorer";
            silent = true;
          };
          condition = cfg.fileExplorer.type == "neo-tree";
        }
      ];
    };
  };
} 