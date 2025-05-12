{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.editing = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable text editing enhancements";
    };
    
    commentToggle = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable comment toggling";
      };
    };
    
    surround = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable surrounding utilities";
      };
    };
    
    formatting = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable auto-formatting";
      };
    };
  };

  config = mkIf (cfg.enable && cfg.editing.enable) {
    programs.nixvim = {
      # Initialize LSP diagnostics visibility global variable
      lua.extraConfig = ''
        _G.isLspDiagnosticsVisible = true
      '';
      
      plugins = {
        # Comment toggling with gcc / gc + motion
        comment-nvim = mkIf cfg.editing.commentToggle.enable {
          enable = true;
          mappings = {
            basic = true;
            extended = true;
          };
          padding = true;
          sticky = true;
          toggler = {
            line = "gcc";
            block = "gbc";
          };
          opleader = {
            line = "gc";
            block = "gb";
          };
        };

        # Text surround management
        surround = mkIf cfg.editing.surround.enable {
          enable = true;
        };
        
        # Auto-formatting
        conform-nvim = mkIf cfg.editing.formatting.enable {
          enable = true;
          formatOnSave = {
            lspFallback = true;
            timeoutMs = 500;
          };
          notifyOnError = true;
          
          # Define formatters for different filetypes
          formattersByFt = {
            lua = [ "stylua" ];
            python = [ "isort" "black" ];
            javascript = [ "prettierd" ];
            typescript = [ "prettierd" ];
            javascriptreact = [ "prettierd" ];
            typescriptreact = [ "prettierd" ];
            json = [ "prettierd" ];
            html = [ "prettierd" ];
            css = [ "prettierd" ];
            scss = [ "prettierd" ];
            markdown = [ "prettierd" ];
            yaml = [ "prettierd" ];
            rust = [ "rustfmt" ];
            nix = [ "nixpkgs_fmt" ];
            go = [ "goimports" "gofmt" ];
            sh = [ "shfmt" ];
            "*" = [ "trim_whitespace" "trim_newlines" "squeeze_blanks" ];
          };
        };
        
        # Multi-cursor editing
        multiple-cursors = {
          enable = true;
        };
        
        # Better line movements
        leap = {
          enable = true;
        };
        
        # Better motions
        flash = {
          enable = true;
          labels = "asdfghjklqwertyuiopzxcvbnm";
          search = {
            mode = "fuzzy";
          };
          jump = {
            inclusive = {
              f = true;
              t = true;
            };
          };
        };
        
        # Highlight unique characters for f/F motions
        easymotion = {
          enable = false; # Disabled in favor of flash/leap
        };
        
        # Undo tree visualization
        undotree = {
          enable = true;
          focusOnToggle = true;
          treeNodeB = "◉";
          windowLayout = 2;
        };
      };
      
      # Keymaps for editing plugins
      keymaps = [
        # Undotree
        {
          key = "<leader>u";
          action = ":UndotreeToggle<CR>";
          mode = "n";
          options = {
            desc = "Toggle undotree";
            silent = true;
          };
        }
        
        # Flash
        {
          key = "s";
          action = ":lua require('flash').jump()<CR>";
          mode = "n";
          options = {
            desc = "Flash jump";
            silent = true;
          };
        }
        {
          key = "S";
          action = ":lua require('flash').treesitter()<CR>";
          mode = "n";
          options = {
            desc = "Flash treesitter";
            silent = true;
          };
        }
        
        # Conform formatting
        {
          key = "<leader>fm";
          action = ":lua require('conform').format()<CR>";
          mode = "n";
          options = {
            desc = "Format document";
            silent = true;
          };
        }
      ];
    };
  };
} 