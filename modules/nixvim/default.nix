{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  imports = [
    ./core.nix
    ./ui.nix
    ./keymaps.nix
    ./plugins
    ./lsp
  ];

  options.modules.nixvim = {
    enable = mkEnableOption "Enable NixVim configuration";
    
    extraPlugins = mkOption {
      type = with types; listOf package;
      default = [];
      description = "Extra vim plugins to install";
    };
    
    plugins = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "Simple plugin configuration";
    };
    
    colorscheme = mkOption {
      type = types.str;
      default = "catppuccin";
      description = "Colorscheme to use";
    };
  };

  config = mkIf cfg.enable {
    # Forward colorscheme to UI theme
    modules.nixvim.ui.theme = cfg.colorscheme;
    
    # Forward plugins settings if they exist
    modules.nixvim.fileExplorer.type = mkIf (cfg.plugins.neo-tree.enable or false) "neo-tree";
    
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      
      # Forward extraPlugins
      extraPlugins = cfg.extraPlugins;
      
      # Forward basic plugin configurations
      plugins = {
        telescope.enable = mkIf (cfg.plugins.telescope.enable or false) true;
        lualine.enable = mkIf (cfg.plugins.lualine.enable or false) true;
        treesitter.enable = mkIf (cfg.plugins.treesitter.enable or false) true;
        gitsigns.enable = mkIf (cfg.plugins.gitsigns.enable or false) true;
        comment-nvim.enable = mkIf (cfg.plugins.comment-nvim.enable or false) true;
      };
    };
  };
} 