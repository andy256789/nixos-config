{ config, lib, pkgs, inputs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  imports = [
    ./options.nix
    ./plugins
    ./keymaps.nix
    ./colorscheme.nix
    ./lsp
    ./ui.nix
  ];

  options.modules.nixvim = {
    enable = mkEnableOption "Enable NixVim configuration";
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      
      # Default configurations that should always be enabled
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
  };
} 