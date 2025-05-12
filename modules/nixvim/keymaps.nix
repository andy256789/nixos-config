{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.keymaps = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable keymaps";
    };
  };

  config = mkIf (cfg.enable && cfg.keymaps.enable) {
    programs.nixvim = {
      keymaps = [
        # Basic navigation and editing
        {
          key = "<C-d>";
          action = "<C-d>zz";
          mode = "n";
          options = { desc = "Scroll down with cursor centered"; };
        }
        {
          key = "<C-u>";
          action = "<C-u>zz";
          mode = "n";
          options = { desc = "Scroll up with cursor centered"; };
        }
        {
          key = "n";
          action = "nzzzv";
          mode = "n";
          options = { desc = "Next search result with cursor centered"; };
        }
        {
          key = "N";
          action = "Nzzzv";
          mode = "n";
          options = { desc = "Previous search result with cursor centered"; };
        }
        
        # Visual mode
        {
          key = "J";
          action = ":m '>+1<CR>gv=gv";
          mode = "v";
          options = { desc = "Move selected lines down"; };
        }
        {
          key = "K";
          action = ":m '<-2<CR>gv=gv";
          mode = "v";
          options = { desc = "Move selected lines up"; };
        }
        {
          key = "<";
          action = "<gv";
          mode = "v";
          options = { desc = "Indent left and reselect"; };
        }
        {
          key = ">";
          action = ">gv";
          mode = "v";
          options = { desc = "Indent right and reselect"; };
        }
        
        # Better deletion
        {
          key = "<leader>d";
          action = "\"_d";
          mode = ["n" "v"];
          options = { desc = "Delete without copying to register"; };
        }
        
        # Window management
        {
          key = "<leader>sv";
          action = "<C-w>v";
          mode = "n";
          options = { desc = "Split window vertically"; };
        }
        {
          key = "<leader>sh";
          action = "<C-w>s";
          mode = "n";
          options = { desc = "Split window horizontally"; };
        }
        {
          key = "<leader>se";
          action = "<C-w>=";
          mode = "n";
          options = { desc = "Make splits equal size"; };
        }
        {
          key = "<leader>sx";
          action = ":close<CR>";
          mode = "n";
          options = { desc = "Close current split"; };
        }
        
        # Tab management
        {
          key = "<leader>to";
          action = ":tabnew<CR>";
          mode = "n";
          options = { desc = "Open new tab"; };
        }
        {
          key = "<leader>tx";
          action = ":tabclose<CR>";
          mode = "n";
          options = { desc = "Close current tab"; };
        }
        {
          key = "<leader>tn";
          action = ":tabn<CR>";
          mode = "n";
          options = { desc = "Go to next tab"; };
        }
        {
          key = "<leader>tp";
          action = ":tabp<CR>";
          mode = "n";
          options = { desc = "Go to previous tab"; };
        }
        
        # Clear search highlighting
        {
          key = "<Esc>";
          action = ":nohl<CR>";
          mode = "n";
          options = { desc = "Clear search highlights"; };
        }
        
        # Format file
        {
          key = "<leader>f";
          action = "vim.lsp.buf.format";
          mode = "n";
          options = { desc = "Format document"; };
          lua = true;
        }
      ];
    };
  };
} 