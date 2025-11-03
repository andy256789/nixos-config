{ config, pkgs, hyprland, settings, inputs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        # ThinkPad T490s specific optimizations from nixos-hardware
        # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490s
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
        auto-optimise-store = true;  # Automatic store optimization
    };
    
    # Automatic garbage collection
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
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

    # Audio - PipeWire (modern replacement for PulseAudio)
    security.rtkit.enable = true;  # RealtimeKit for better audio performance
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;  # PulseAudio compatibility
        jack.enable = true;   # JACK compatibility
        wireplumber.enable = true;  # Session manager
    };
    # Explicitly disable PulseAudio (using PipeWire instead)
    services.pulseaudio.enable = false;

    # Display and window manager
    services.xserver.enable = true;
    # T490s has Intel integrated graphics, not AMD
    services.xserver.videoDrivers = ["modesetting"];
    
    # Enable OpenGL and Mesa (Intel graphics)
    hardware.graphics = {
        enable = true;
        enable32Bit = true;  # Support for 32-bit applications
        extraPackages = with pkgs; [
            intel-media-driver  # LIBVA_DRIVER_NAME=iHD
            intel-vaapi-driver  # LIBVA_DRIVER_NAME=i965 (older but works better in some cases)
        ];
    };

    # Bulgarian keyboard layout with phonetic variant
    services.xserver.xkb = {
        layout = "us,bg(phonetic)";
        options = "grp:alt_shift_toggle";
    };

    # Console keyboard
    console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
    };

    # Intel kernel module options (T490s has Intel UHD 620)
    boot.kernelModules = [ "kvm-intel" ];
    boot.kernelParams = [
        "i915.enable_fbc=1"          # Enable framebuffer compression
        "i915.enable_psr=1"          # Enable panel self refresh
        "i915.fastboot=1"            # Try to skip VGA initialization
    ];

    # Display Manager
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };
    
    # Flatpak support
    services.flatpak.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        config.common.default = "*";
    };

    # Docker
    virtualisation.docker = {
        enable = true;
        enableOnBoot = false;  # Don't start on boot to save resources
    };

    # Virtualization with virt-manager
    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
            # OVMF firmware is now available by default, no need to configure
        };
    };
    virtualisation.spiceUSBRedirection.enable = true;

    # Hyprland
    programs.hyprland = {
        enable = true;
        package = pkgs.hyprland;
        xwayland.enable = true;
    };

    # Essential system packages
    environment.systemPackages = with pkgs; [
        home-manager
        git
        vim
        neovim
        wget
        curl
        htop
        btop  # Modern resource monitor
        mesa
        wayland-utils
        wl-clipboard  # Wayland clipboard utilities
        xdg-utils
        pciutils
        usbutils
        file
        tree
        unzip
        zip
        pavucontrol  # PulseAudio/PipeWire volume control
        networkmanagerapplet
    ];

    # Shell
    programs.fish.enable = true;
    
    # SSH daemon
    services.openssh = {
        enable = true;
        settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
    };

    # Power Management for Laptops
    services.thermald.enable = true;  # Thermal management for Intel/AMD
    
    # Choose ONE of these power management tools:
    # Option 1: TLP (traditional, very stable)
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
            
            START_CHARGE_THRESH_BAT0 = 40;  # Battery charge thresholds
            STOP_CHARGE_THRESH_BAT0 = 80;   # Extend battery lifespan
        };
    };
    
    # Option 2: auto-cpufreq (modern alternative, comment out TLP if using this)
    # services.auto-cpufreq = {
    #     enable = true;
    #     settings = {
    #         battery = {
    #             governor = "powersave";
    #             turbo = "never";
    #         };
    #         charger = {
    #             governor = "performance";
    #             turbo = "auto";
    #         };
    #     };
    # };

    # Laptop lid behavior
    services.logind.settings = {
        Login = {
            HandleLidSwitch = "suspend";
            HandleLidSwitchExternalPower = "lock";
            HandlePowerKey = "suspend";
            IdleAction = "suspend";
            IdleActionSec = "30min";
        };
    };

    # Enable firmware updates
    services.fwupd.enable = true;

    # Enable TRIM for SSD
    services.fstrim.enable = true;

    # Environment variables
    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        WLR_RENDERER_ALLOW_SOFTWARE = "1";
        QT_QPA_PLATFORM = "wayland";
        GDK_BACKEND = "wayland";
        
        # Intel-specific optimizations
        LIBVA_DRIVER_NAME = "iHD";  # Use Intel iHD driver for hardware acceleration
        
        # Additional Wayland variables
        MOZ_ENABLE_WAYLAND = "1";
        XDG_SESSION_TYPE = "wayland";
    };

    # System state version - NEVER change this after initial install!
    system.stateVersion = "25.05";
}
