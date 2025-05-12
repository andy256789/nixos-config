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

# AMD GPU Boost & 170Hz Fix
	services.xserver.extraConfig = ''
		Section "Monitor"
		Identifier "DP-2"
		Modeline "2560x1440_170.00" 974.00 2560 2792 3080 3600 1440 1443 1448 1592 -hsync +vsync
		Option "PreferredMode" "2560x1440_170.00"
		EndSection

		Section "Device"
		Identifier "AMD"
		Driver "amdgpu"
		Option "TearFree" "true"
		Option "VariableRefresh" "true"
		Option "DRI" "3"
		EndSection
		'';

# AMD kernel module options
	boot.kernelModules = [ "amdgpu" ];

	boot.extraModprobeConfig = ''
		options amdgpu dc=1
		options amdgpu vrr_support=1
		options amdgpu si_support=0
		options amdgpu cik_support=0
		'';

# Force performance governor (optional)
	services.udev.extraRules = ''
		SUBSYSTEM=="drm", ACTION=="change", RUN+="${pkgs.util-linux}/bin/echo performance > /sys/class/drm/card0/device/power_dpm_force_performance_level"
		'';


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
