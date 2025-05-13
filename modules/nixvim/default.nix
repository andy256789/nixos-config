{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.nixvim;
in
{
  options.modules.nixvim = {
    enable = mkEnableOption "Enable nixvim";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      
      # Basic vim options
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
      
      # Colorscheme
      colorschemes.tokyonight = {
        enable = true;
        style = "night";
      };

      # Basic plugins
      plugins = {
        # File explorer
        nvim-tree = {
          enable = true;
          openOnSetup = true;
        };
        
        # Status line
        lualine.enable = true;
        
        # Fuzzy finder
        telescope.enable = true;
        
        # Git integration
        gitsigns.enable = true;
        
        # Better highlighting
        treesitter.enable = true;
      };
      
      # Keymaps
      keymaps = [
        # File explorer
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>NvimTreeToggle<CR>";
          options = {
            silent = true;
            desc = "Toggle file explorer";
          };
        }
        
        # Telescope (fuzzy finder)
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<CR>";
          options = {
            silent = true;
            desc = "Find files";
          };
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<CR>";
          options = {
            silent = true;
            desc = "Live grep";
          };
        }
      ];
    };
  };
} 