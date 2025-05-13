{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.packages;
in {
    options.modules.packages = {
        enable = mkEnableOption "Enable default packages";

        terminal = {
            enable = mkEnableOption "Enable terminal packages";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    ghostty
                    foot
                ];
                description = "Terminal packages to install";
            };
        };

        fileManagers = {
            enable = mkEnableOption "Enable file manager packages";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    nemo
                    yazi
                ];
                description = "File manager packages to install";
            };
        };

        development = {
            enable = mkEnableOption "Enable development packages";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    git
                    code-cursor

                    # Compilers and build tools
                    gcc
                    gnumake
                    cmake
                    pkg-config

                    # Language servers and formatters
                    nodePackages.typescript-language-server
                    nodePackages.prettier
                    nixpkgs-fmt
                ];
                description = "Development packages to install";
            };
        };

        browsers = {
            enable = mkEnableOption "Enable browser packages";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    firefox
                ];
                description = "Browser packages to install";
            };
        };

        media = {
            enable = mkEnableOption "Enable media packages";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    mpv
                    imv
                    spotify
                ];
                description = "Media packages to install";
            };
        };

        utilities = {
            enable = mkEnableOption "Enable utility packages";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    btop
                    fastfetch
                    ripgrep
                    fd
                    bat
                    eza
                    fzf
                    jq
                    yq
                    bottom
                    htop
                    duf
                    ncdu
                    unzip
                    p7zip
                    wget
                    curl
                    rsync
                ];
                description = "Utility packages to install";
            };
        };

        communication = {
            enable = mkEnableOption "Enable communication packages";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    discord
                ];
                description = "Communication packages to install";
            };
        };
    };

    config = mkIf cfg.enable {
        home.packages = with pkgs; []
            ++ (if cfg.terminal.enable then cfg.terminal.packages else [])
            ++ (if cfg.fileManagers.enable then cfg.fileManagers.packages else [])
            ++ (if cfg.development.enable then cfg.development.packages else [])
            ++ (if cfg.browsers.enable then cfg.browsers.packages else [])
            ++ (if cfg.media.enable then cfg.media.packages else [])
            ++ (if cfg.utilities.enable then cfg.utilities.packages else [])
            ++ (if cfg.communication.enable then cfg.communication.packages else []);
    };
} 
