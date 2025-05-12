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
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
  };
} 