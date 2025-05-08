{ config, pkgs, hyprland, username, ... }:

{
  imports = [
    ./home.nix
    ./hardware-configuration.nix
  ];

# Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  virtualisation.vmware.guest.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "andy-desktop";
  time.timeZone = "Europe/Sofia";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    shell = pkgs.fish;
  };


  networking.networkmanager.enable = true;

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    kitty
    foot
    fish
    neovim
  ];

  programs.fish.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  system.stateVersion = "24.11";
}
