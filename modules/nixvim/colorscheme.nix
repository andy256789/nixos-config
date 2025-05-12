{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
  themeCfg = config.themes;
in {
  options.modules.nixvim.colorscheme = {
    name = mkOption {
      type = types.str;
      default = "catppuccin";
      description = "The colorscheme to use";
    };

    variant = mkOption {
      type = types.enum [ "auto" "latte" "frappe" "macchiato" "mocha" ];
      default = "auto";
      description = "Variant of the colorscheme (auto will use system theme)";
    };
    
    transparent = mkOption {
      type = types.bool;
      default = false;
      description = "Enable transparent background";
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      colorschemes = {
        catppuccin = {
          enable = cfg.colorscheme.name == "catppuccin";
          settings = {
            flavour = if cfg.colorscheme.variant == "auto" 
              then (if themeCfg.isDark then "mocha" else "latte") 
              else cfg.colorscheme.variant;
            transparent_background = cfg.colorscheme.transparent;
            term_colors = true;
            integrations = {
              treesitter = true;
              native_lsp.enabled = true;
              telescope.enabled = true;
              nvimtree = true;
              which_key = true;
              neotree = true;
              mason = true;
              indent_blankline.enabled = true;
              notify = true;
              symbols_outline = true;
              cmp = true;
              gitsigns = true;
              lsp_trouble = true;
              fidget = true;
              markdown = true;
              neotest = true;
            };
          };
        };
        
        tokyonight = {
          enable = cfg.colorscheme.name == "tokyonight";
          style = if themeCfg.isDark then "storm" else "day";
          transparent = cfg.colorscheme.transparent;
          terminal_colors = true;
        };
        
        # Add more colorscheme options as needed
      };
    };
  };
} 