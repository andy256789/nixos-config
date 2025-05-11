{ config, pkgs, hyprland, settings, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  #virtualisation.vmware.guest.enable = true;

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # System settings
  networking.hostName = settings.hostname;
  time.timeZone = "Europe/Sofia";

  # User configuration
  users.users.${settings.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
  };

  # Networking
  networking.networkmanager.enable = true;

  # Display and window manager
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  # Enable OpenGL and Mesa
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ mesa ];
  };

  # System packages (only system-level packages that shouldn't be in home-manager)
  environment.systemPackages = with pkgs; [
    git
    vim
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
  };

  # System state version
  system.stateVersion = "24.11";
}
