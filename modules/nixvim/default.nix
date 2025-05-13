{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim = {
    enable = mkEnableOption "enable nixvim";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      globals = {
        mapleader = " ";
      };

      options = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        termguicolors = true;
        ignorecase = true;
        smartcase = true;
        clipboard = "unnamedplus";
      };

      colorschemes.tokyonight = {
        enable = true;
        style = "night";
      };

      plugins = {
        nvim-tree = {
          enable = true;
          openOnSetup = true;
        };

        lualine.enable = true;
        telescope.enable = true;
        gitsigns.enable = true;
        treesitter.enable = true;
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>NvimTreeToggle<cr>";
          options = {
            silent = true;
            desc = "toggle file explorer";
          };
        }
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<cr>";
          options = {
            silent = true;
            desc = "find files";
          };
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<cr>";
          options = {
            silent = true;
            desc = "live grep";
          };
        }
      ];
    };
  };
}
