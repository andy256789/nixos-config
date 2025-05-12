{ config, lib, pkgs, ... }:

{
  imports = [
    ./file-explorer.nix
    ./telescope.nix
    ./git.nix
    ./completion.nix
    ./editing.nix
  ];
} 