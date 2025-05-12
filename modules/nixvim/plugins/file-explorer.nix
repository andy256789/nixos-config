{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.fileExplorer = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable file explorer";
    };

    type = mkOption {
      type = types.enum [ "neo-tree" "nvim-tree" ];
      default = "neo-tree";
      description = "File explorer plugin to use";
    };
  };

  config = mkIf (cfg.enable && cfg.fileExplorer.enable) {
    programs.nixvim = {
      plugins = {
        neo-tree = {
          enable = cfg.fileExplorer.type == "neo-tree";
          closeIfLastWindow = true;
          defaultSource = "filesystem";
          enableGitStatus = true;
          enableModifiedMarkers = true;
          enableRefreshOnWrite = true;
          sources = [ "filesystem" "buffers" "git_status" "document_symbols" ];
          addBlankLineAtTop = true;
          popupBorderStyle = "rounded";
          
          window = {
            position = "left";
            width = 30;
            mappings = {
              "<space>" = "toggle_node";
              "h" = "close_node";
              "l" = "open";
            };
          };
          
          filesystem = {
            followCurrentFile = true;
            useLibuvFileWatcher = true;
            filteredItems = {
              hideByName = [
                "node_modules"
                ".git"
                ".DS_Store"
              ];
              alwaysShow = [
                ".gitignored"
              ];
              neverShow = [
                ".DS_Store"
                "thumbs.db"
              ];
            };
          };
        };

        nvim-tree = {
          enable = cfg.fileExplorer.type == "nvim-tree";
          disableNetrw = true;
          hijackNetrw = true;
          openOnSetup = false;
          ignoreFileTypeFilters = [ "dashboard" "startify" "alpha" ];
          sort = {
            sorter = "name";
            folders_first = true;
            files_first = false;
          };
          view = {
            width = 30;
            side = "left";
            number = false;
            relativenumber = false;
            signcolumn = "yes";
          };
          renderer = {
            addTrailing = true;
            groupEmpty = true;
            highlightGit = true;
            highlightOpenedFiles = "all";
            rootFolderLabel = ":~:s?$?/..?";
          };
          filters = {
            dotfiles = false;
            custom = [ "^.git$" "node_modules" "\\.cache" ];
          };
          git = {
            enable = true;
            ignore = true;
          };
          actions = {
            changeDir.enable = true;
            openFile.quitOnOpen = false;
          };
        };
      };

      # Add keymaps for file explorer
      keymaps = mkIf (cfg.fileExplorer.enable) [
        {
          key = "<leader>e";
          action = cfg.fileExplorer.type == "neo-tree" 
            ? ":Neotree toggle<CR>" 
            : ":NvimTreeToggle<CR>";
          mode = "n";
          options = {
            desc = "Toggle file explorer";
            silent = true;
          };
        }
        {
          key = "<leader>o";
          action = cfg.fileExplorer.type == "neo-tree" 
            ? ":Neotree focus<CR>" 
            : ":NvimTreeFocus<CR>";
          mode = "n";
          options = {
            desc = "Focus file explorer";
            silent = true;
          };
        }
      ];
    };
  };
} 