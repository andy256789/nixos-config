{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.nixvim;
in {
    imports = [
        ./options.nix
        ./keymaps.nix
        ./plugins
    ];

    options.modules.nixvim = {
        enable = mkEnableOption "enable nixvim";
    };

    config = mkIf cfg.enable {
        programs.nixvim = {
            enable = true;

            defaultEditor = true;
            vimAlias = true;
        };
    };
}
