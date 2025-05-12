{ config, lib, pkgs, ... }:

{
  imports = [
    ./core.nix
    ./languages.nix
    ./diagnostics.nix
  ];
} 