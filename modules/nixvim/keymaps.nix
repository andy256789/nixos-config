{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.keymaps = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable default keymaps";
    };
  };

  config = mkIf (cfg.enable && cfg.keymaps.enable) {
    programs.nixvim.globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    programs.nixvim.keymaps = [
      # Visual mode mappings
      {
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        mode = "v";
        options = {
          desc = "Move lines down in visual selection";
          silent = true;
        };
      }
      {
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        mode = "v";
        options = {
          desc = "Move lines up in visual selection";
          silent = true;
        };
      }
      {
        key = "<";
        action = "<gv";
        mode = "v";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = ">";
        action = ">gv";
        mode = "v";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "p";
        action = "\"_dp";
        mode = "v";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>d";
        action = "\"_d";
        mode = "v";
        options = {
          noremap = true;
          silent = true;
        };
      }
      
      # Normal mode mappings
      {
        key = "J";
        action = "mzJ`z";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<C-d>";
        action = "<C-d>zz";
        mode = "n";
        options = {
          desc = "Move down in buffer with cursor centered";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<C-u>";
        action = "<C-u>zz";
        mode = "n";
        options = {
          desc = "Move up in buffer with cursor centered";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "n";
        action = "nzzzv";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "N";
        action = "Nzzzv";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>Y";
        action = "\"+Y";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>d";
        action = "\"_d";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>p";
        action = "\"_dP";
        mode = "x";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<C-c>";
        action = "<Esc>";
        mode = "i";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<C-c>";
        action = ":nohl<CR>";
        mode = "n";
        options = {
          desc = "Clear search highlights";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>f";
        action = "vim.lsp.buf.format";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
        lua = true;
      }
      {
        key = "Q";
        action = "<nop>";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<C-f>";
        action = "<cmd>silent !tmux neww tmux-sessionizer<CR>";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "x";
        action = "\"_x";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>s";
        action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
        mode = "n";
        options = {
          desc = "Replace word cursor is on globally";
          noremap = true;
        };
      }
      {
        key = "<leader>x";
        action = "<cmd>!chmod +x %<CR>";
        mode = "n";
        options = {
          desc = "Makes file executable";
          noremap = true;
          silent = true;
        };
      }
      
      # Tab management
      {
        key = "<leader>to";
        action = "<cmd>tabnew<CR>";
        mode = "n";
        options = {
          desc = "Open new tab";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>tx";
        action = "<cmd>tabclose<CR>";
        mode = "n";
        options = {
          desc = "Close current tab";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>tn";
        action = "<cmd>tabn<CR>";
        mode = "n";
        options = {
          desc = "Go to next tab";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>tp";
        action = "<cmd>tabp<CR>";
        mode = "n";
        options = {
          desc = "Go to previous tab";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>tf";
        action = "<cmd>tabnew %<CR>";
        mode = "n";
        options = {
          desc = "Open current buffer in new tab";
          noremap = true;
          silent = true;
        };
      }
      
      # Split management
      {
        key = "<leader>sv";
        action = "<C-w>v";
        mode = "n";
        options = {
          desc = "Split window vertically";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>sh";
        action = "<C-w>s";
        mode = "n";
        options = {
          desc = "Split window horizontally";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>se";
        action = "<C-w>=";
        mode = "n";
        options = {
          desc = "Make splits equal size";
          noremap = true;
          silent = true;
        };
      }
      {
        key = "<leader>sx";
        action = "<cmd>close<CR>";
        mode = "n";
        options = {
          desc = "Close current split";
          noremap = true;
          silent = true;
        };
      }
      
      # Copy filepath
      {
        key = "<leader>fp";
        action = ''
        function()
          local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
          vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
          print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
        end
        '';
        mode = "n";
        options = {
          desc = "Copy file path to clipboard";
          noremap = true;
          silent = true;
        };
        lua = true;
      }
      
      # Toggle LSP diagnostics
      {
        key = "<leader>lx";
        action = ''
        function()
            _G.isLspDiagnosticsVisible = not _G.isLspDiagnosticsVisible
            vim.diagnostic.config({
                virtual_text = _G.isLspDiagnosticsVisible,
                underline = _G.isLspDiagnosticsVisible
            })
        end
        '';
        mode = "n";
        options = {
          desc = "Toggle LSP diagnostics";
          noremap = true;
          silent = true;
        };
        lua = true;
      }
    ];
    
    programs.nixvim.autoGroups = {
      "kickstart-highlight-yank" = {
        clear = true;
      };
    };
    
    programs.nixvim.autoCmd = [
      {
        event = "TextYankPost";
        group = "kickstart-highlight-yank";
        pattern = "*";
        callback = {
          __raw = ''
          function()
              vim.highlight.on_yank()
          end
          '';
        };
        desc = "Highlight when yanking (copying) text";
      }
    ];
  };
} 