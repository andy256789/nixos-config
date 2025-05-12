{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  imports = [
    ./telescope.nix
    ./completion.nix
    # ./git.nix
    ./file-explorer.nix
  ];
} 