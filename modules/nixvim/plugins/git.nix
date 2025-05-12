{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.git = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Git integration plugins";
    };
  };

  config = mkIf (cfg.enable && cfg.git.enable) {
    programs.nixvim = {
      plugins = {
        # Git commands inside neovim
        neogit = {
          enable = true;
          disableSigns = false;
          disableHint = false;
          disableContextHighlighting = false;
          disableCommitConfirmation = false;
          autoRefresh = true;
          kind = "split";
          
          sections = {
            recent = {
              folded = false;
            };
            untracked = {
              folded = true;
            };
            unstaged = {
              folded = false;
            };
            staged = {
              folded = false;
            };
            stashes = {
              folded = true;
            };
            unpulled = {
              folded = true;
            };
            unmerged = {
              folded = false;
            };
            recent = {
              folded = false;
            };
          };
        };

        # Lazygit integration
        lazygit = {
          enable = true;
        };

        # Git blame annotations
        gitblame = {
          enable = true;
          messageTemplate = "<author> • <summary> • <date>";
          delay = 1000;
          virtualTextFormat = {
            delay = 1000;
            format = "* %s";
          };
        };

        # Git integration for buffers
        fugitive = {
          enable = true;
        };
      };

      # Git mappings
      keymaps = [
        # Neogit
        {
          key = "<leader>gg";
          action = ":Neogit<CR>";
          mode = "n";
          options = {
            desc = "Open Neogit";
            silent = true;
          };
        }
        # Lazygit
        {
          key = "<leader>gl";
          action = ":LazyGit<CR>";
          mode = "n";
          options = {
            desc = "Open LazyGit";
            silent = true;
          };
        }
        # Git blame toggle
        {
          key = "<leader>gb";
          action = ":GitBlameToggle<CR>";
          mode = "n";
          options = {
            desc = "Toggle Git blame";
            silent = true;
          };
        }
        # Git status
        {
          key = "<leader>gs";
          action = ":Git<CR>";
          mode = "n";
          options = {
            desc = "Git status";
            silent = true;
          };
        }
        # Git commit
        {
          key = "<leader>gc";
          action = ":Git commit<CR>";
          mode = "n";
          options = {
            desc = "Git commit";
            silent = true;
          };
        }
        # Git push
        {
          key = "<leader>gp";
          action = ":Git push<CR>";
          mode = "n";
          options = {
            desc = "Git push";
            silent = true;
          };
        }
        # Git pull
        {
          key = "<leader>gu";
          action = ":Git pull<CR>";
          mode = "n";
          options = {
            desc = "Git pull";
            silent = true;
          };
        }
      ];
    };
  };
} 