{ config, pkgs, hyprland, username, ... }:

{
  imports = [
    ./home.nix
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  virtualisation.vmware.guest.enable = true;

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # System settings
  networking.hostName = "andy-desktop";
  time.timeZone = "Europe/Sofia";

  # User configuration
  users.users.${username} = {
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
    package = hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    kitty
    firefox
    foot
    fish
    neovim
    waybar
    rofi-wayland
    dunst
    libnotify
  ];

  # Shell
  programs.fish.enable = true;

  # Environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Enable Wayland for Ozone-based apps (e.g., Firefox)
    WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor issues in some VMs
    QT_QPA_PLATFORM = "wayland"; # Force Qt apps to use Wayland
    GDK_BACKEND = "wayland"; # Force GTK apps to use Wayland
  };

  # System state version
  system.stateVersion = "24.11";
}