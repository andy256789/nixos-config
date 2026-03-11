{ pkgs, settings, ... }:
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
        configurationLimit = 10;
    };

    # Nix settings
    nixpkgs.config.allowUnfree = true;
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        allowed-users = [ "@wheel" ];
        trusted-users = [ "root" "@wheel" ];
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
        auto-optimise-store = true;
    };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    system.autoUpgrade = {
        enable = true;
        operation = "boot";
        dates = "daily";
        randomizedDelaySec = "45min";
        allowReboot = false;
    };

    # System settings
    networking.hostName = settings.hostname;
    time.timeZone = "Europe/Sofia";

    # Locale settings
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "bg_BG.UTF-8";
        LC_IDENTIFICATION = "bg_BG.UTF-8";
        LC_MEASUREMENT = "bg_BG.UTF-8";
        LC_MONETARY = "bg_BG.UTF-8";
        LC_NAME = "bg_BG.UTF-8";
        LC_NUMERIC = "bg_BG.UTF-8";
        LC_PAPER = "bg_BG.UTF-8";
        LC_TELEPHONE = "bg_BG.UTF-8";
        LC_TIME = "bg_BG.UTF-8";
    };

    # User configuration
    users.users.${settings.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "input" "docker" "bluetooth" "libvirtd" ];
        shell = pkgs.fish;
    };

    # Networking
    networking.networkmanager.enable = true;

    # Firewall
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ ];
        allowedUDPPorts = [ ];
    };

    # Bluetooth
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
            General = {
                Experimental = true;
                Enable = "Source,Sink,Media,Socket";
            };
        };
    };
    services.blueman.enable = true;
    services.udev.packages = [ pkgs.game-devices-udev-rules ];

    # Audio with PipeWire
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
    };
    services.pulseaudio.enable = false;

    # Display and graphics
    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "modesetting" ];

    hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
            intel-media-driver
        ];
    };

    # Keyboard configuration
    services.xserver.xkb = {
        layout = "us,bg(phonetic)";
        options = "grp:alt_shift_toggle";
    };

    console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
    };

    # Kernel configuration
    boot.kernelModules = [ "kvm-intel" ];
    boot.kernelParams = [
        "i915.enable_fbc=1"
        "i915.enable_psr=1"
        "i915.fastboot=1"
    ];

    # Display manager
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };

    # Flatpak
    services.flatpak.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
    };

    # Virtualization
    virtualisation.docker = {
        enable = true;
        enableOnBoot = false;
    };

    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
        };
    };
    virtualisation.spiceUSBRedirection.enable = true;

    # Hyprland
    programs.hyprland = {
        enable = true;
        package = pkgs.hyprland;
        xwayland.enable = true;
        withUWSM = true;
    };

    # System packages
    environment.systemPackages = with pkgs; [
        mesa
        bluez
        wayland-utils
        xdg-utils
        pciutils
        usbutils
    ];

    # Shell
    programs.fish.enable = true;

    # SSH
    services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
    };

    # SSH abuse protection
    services.fail2ban.enable = true;

    # Power management
    services.thermald.enable = true;

    services.tlp = {
        enable = true;
        settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 30;

            START_CHARGE_THRESH_BAT0 = 75;
            STOP_CHARGE_THRESH_BAT0 = 80;
        };
    };

    services.logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "lock";
        HandlePowerKey = "suspend";
        IdleAction = "suspend";
        IdleActionSec = "30min";
    };
    # Firmware updates
    services.fwupd.enable = true;

    # SSD optimization
    services.fstrim.enable = true;

    # Environment variables
    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland";
        LIBVA_DRIVER_NAME = "iHD";
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";
    };

    # System state version
    system.stateVersion = settings.stateVersion;
}
