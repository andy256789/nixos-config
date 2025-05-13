{
  config.programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      # Toggle file explorer
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<cr>";
        options = {
          silent = true;
          desc = "toggle file explorer";
        };
      }

      # Moving text in visual mode
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options = {
          desc = "moves lines down in visual selection";
        };
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options = {
          desc = "moves lines up in visual selection";
        };
      }

      # Join lines keeping cursor position
      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
      }

      # Centered scrolling
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options = {
          desc = "move down in buffer with cursor centered";
        };
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options = {
          desc = "move up in buffer with cursor centered";
        };
      }

      # Keep search terms centered
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
      }

      # Keep indentation in visual mode
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options = { silent = true; };
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options = { silent = true; };
      }

      # Better paste
      {
        mode = "x";
        key = "<leader>p";
        action = "\"_dP";
      }
      {
        mode = "v";
        key = "p";
        action = "\"_dp";
        options = { silent = true; };
      }

      # Clipboard operations
      {
        mode = "n";
        key = "<leader>Y";
        action = "\"+Y";
        options = { silent = true; };
      }
      {
        mode = "n";
        key = "<leader>d";
        action = "\"_d";
        options = { silent = true; };
      }
      {
        mode = "v";
        key = "<leader>d";
        action = "\"_d";
        options = { silent = true; };
      }

      # Escape with Ctrl-C
      {
        mode = "i";
        key = "<C-c>";
        action = "<Esc>";
      }
      {
        mode = "n";
        key = "<C-c>";
        action = ":nohl<CR>";
        options = {
          desc = "Clear search hl";
          silent = true;
        };
      }

      # Format with LSP
      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
      }

      # Disable Q in normal mode
      {
        mode = "n";
        key = "Q";
        action = "<nop>";
      }

      # Tmux sessionizer
      {
        mode = "n";
        key = "<C-f>";
        action = "<cmd>silent !tmux neww tmux-sessionizer<CR>";
      }

      # Delete without yanking
      {
        mode = "n";
        key = "x";
        action = "\"_x";
        options = { silent = true; };
      }

      # Global search and replace
      {
        mode = "n";
        key = "<leader>s";
        action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
        options = {
          desc = "Replace word cursor is on globally";
        };
      }

      # Make file executable
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>!chmod +x %<CR>";
        options = {
          silent = true;
          desc = "makes file executable";
        };
      }

      # Tab management
      {
        mode = "n";
        key = "<leader>to";
        action = "<cmd>tabnew<CR>";
        options = { desc = "Open new tab"; };
      }
      {
        mode = "n";
        key = "<leader>tx";
        action = "<cmd>tabclose<CR>";
        options = { desc = "Close current tab"; };
      }
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>tabn<CR>";
        options = { desc = "Go to next tab"; };
      }
      {
        mode = "n";
        key = "<leader>tp";
        action = "<cmd>tabp<CR>";
        options = { desc = "Go to previous tab"; };
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>tabnew %<CR>";
        options = { desc = "Open current buffer in new tab"; };
      }

      # Split window management
      {
        mode = "n";
        key = "<leader>sv";
        action = "<C-w>v";
        options = { desc = "Split window vertically"; };
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<C-w>s";
        options = { desc = "Split window horizontally"; };
      }
      {
        mode = "n";
        key = "<leader>se";
        action = "<C-w>=";
        options = { desc = "Make splits equal size"; };
      }
      {
        mode = "n";
        key = "<leader>sx";
        action = "<cmd>close<CR>";
        options = { desc = "Close current split"; };
      }

      # Copy filepath to clipboard
      {
        mode = "n";
        key = "<leader>fp";
        action = ":let @+ = expand('%:~')<CR>:echo 'File path copied to clipboard: ' . expand('%:~')<CR>";
        options = { desc = "Copy file path to clipboard"; };
      }

      # Toggle LSP diagnostics
      {
        mode = "n";
        key = "<leader>lx";
        action = "<cmd>lua vim.diagnostic.config({virtual_text = not vim.diagnostic.config().virtual_text, underline = not vim.diagnostic.config().underline})<CR>";
        options = { desc = "Toggle LSP diagnostics"; };
      }
    ];
  };

  # Move autoGroups and autoCmd inside programs.nixvim
  config.programs.nixvim.autoGroups = {
    highlight_yank = { clear = true; };
  };

  config.programs.nixvim.autoCmd = [
    {
      event = "TextYankPost";
      group = "highlight_yank";
      desc = "Highlight when yanking (copying) text";
      callback = {
        __raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      };
    }
  ];
} 