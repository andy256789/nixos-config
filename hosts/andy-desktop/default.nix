{ config, pkgs, hyprland, settings, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    # Bootloader
    boot.loader.systemd-boot.enable = false;

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        devices = [ "nodev" ];
    };

    # Nix settings
    nixpkgs.config.allowUnfree = true;
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = [
            "https://cache.nixos.org?priority=10"

            "https://nix-community.cachix.org"
            "https://hyprland.cachix.org"
            "https://yazi.cachix.org"
        ];
        trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        ];
    };

    # System settings
    networking.hostName = settings.hostname;
    time.timeZone = "Europe/Sofia";

    # User configuration
    users.users.${settings.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "input" "docker" "bluetooth" "libvirtd" ];
        shell = pkgs.fish;
    };

    # Networking
    networking.networkmanager.enable = true;

    # Bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Experimental = true;
            };
        };
    };
    services.blueman.enable = true;

    # Display and window manager
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["amdgpu"];

    # Enable OpenGL and Mesa
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [ mesa ];
    };


    # AMD kernel module options
    boot.kernelModules = [ "amdgpu" ];
    boot.kernelParams = [
        "amdgpu.dc=1"
        "amdgpu.gpu_recovery=1"
        "amdgpu.ppfeaturemask=0xffffffff"
    ];

    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };

    services.flatpak.enable = true;

    # Docker
    virtualisation.docker.enable = true;

    # Virtualization with virt-manager
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    programs.hyprland = {
        enable = true;
        package = pkgs.hyprland;
        xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
        home-manager
        git
        vim
        neovim
        wget
        mesa
        wayland-utils
    ];

    # Shell
    programs.fish.enable = true;
    services.sshd.enable = true;

    # Environment variables
    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Enable Wayland for Ozone-based apps (e.g., Firefox)
        WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor issues in some VMs
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
        QT_QPA_PLATFORM = "wayland"; # Force Qt apps to use Wayland
        GDK_BACKEND = "wayland"; # Force GTK apps to use Wayland
        
        # AMD-specific fixes for rendering artifacts
        AMD_VULKAN_ICD = "RADV";
        RADV_PERFTEST = "gpl";
        WLR_DRM_NO_ATOMIC = "1";
        __GL_GSYNC_ALLOWED = "0";
        __GL_VRR_ALLOWED = "0";
    };

    # System state version
    system.stateVersion = "25.05";
}
