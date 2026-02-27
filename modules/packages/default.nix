{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.packages;
in {
    options.modules.packages = {
        enable = mkEnableOption "Enable default packages";

        # Core packages - always included when packages are enabled
        core = {
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    # Terminal essentials
                    ghostty
                    foot
                    
                    # File management
                    nemo
                    yazi
                    
                    # Essential utilities
                    wget
                    curl
                    git
                    btop
                    unzip
                    eza
                    ripgrep
                    fd
                    bat
                    fzf
                    jq
                ];
                description = "Core packages that are always installed";
            };
        };

        development = {
            enable = mkEnableOption "Enable development packages";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    # Development tools
                    claude-code
                    code-cursor
                    vscode
                    gcc
                    gnumake
                    cmake
                    pkg-config
                    openssl
                    
                    # Language support
                    pnpm
                    docker
                    prisma-engines
                    dotnet-sdk_8
                    
                    # Database tools
                    postgresql
                    sqlite
                    
                    # Language servers and formatters
                    clang-tools
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
                    # System monitoring
                    fastfetch
                    bottom
                    htop
                    duf
                    ncdu
                    
                    # Archive utilities
                    unrar
                    p7zip
                    
                    # Network utilities
                    rsync
                    nettools
                    
                    # Misc utilities
                    flatpak
                    yq
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
                    teams-for-linux
                    zoom-us
                    remmina
                    obsidian
                    steam
                    wineWow64Packages.staging
                    winetricks
                    foliate

                    anki-bin

                    #university
                    python3
                ];
                description = "Communication packages to install";
            };
        };
    };

    config = mkIf cfg.enable {
        home.packages = with pkgs; []
            ++ cfg.core.packages
            ++ (if cfg.development.enable then cfg.development.packages else [])
            ++ (if cfg.browsers.enable then cfg.browsers.packages else [])
            ++ (if cfg.media.enable then cfg.media.packages else [])
            ++ (if cfg.utilities.enable then cfg.utilities.packages else [])
            ++ (if cfg.communication.enable then cfg.communication.packages else []);
    };
} 
