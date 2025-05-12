{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.hyprland;
  theme = config.themes;
in {
    # Install required packages for Hyprland
    home.packages = with pkgs; [
      wofi                  # Application launcher
      dunst                 # Notification daemon
      libnotify             # Notification library
      swww                  # Wallpaper daemon
      grimblast             # Screenshot tool
      wl-clipboard          # Clipboard tools
      cliphist              # Clipboard history
      hypridle              # Screen locking
      hyprlock              # Screen locker
      networkmanagerapplet  # Network manager applet
      pavucontrol           # Audio control
    ];
 
  options.modules.hyprland = {
    enable = mkEnableOption "Enable Hyprland";
    
    terminal = mkOption {
      type = types.str;
      default = "ghostty";
      description = "Default terminal emulator";
    };
    
    browser = mkOption {
      type = types.str;
      default = "firefox";
      description = "Default web browser";
    };
    
    fileManager = mkOption {
      type = types.str;
      default = "nemo";
      description = "Default file manager";
    };
    
    launcher = mkOption {
      type = types.str;
      default = "wofi --show drun";
      description = "Application launcher command";
    };

    monitors = mkOption {
      type = types.listOf types.str;
      default = ["DP-2,2560x1440@169.83,0x0,1"];
      description = "Monitor configuration";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        monitor = cfg.monitors;

        # Environment variables
        env = [
          "XCURSOR_SIZE,24"
          "QT_QPA_PLATFORMTHEME,qt5ct"
          "HYPRCURSOR_SIZE,24"
          "XCURSOR_THEME,${config.modules.gtk.cursorTheme}"
        ];

        # General settings
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(${builtins.substring 1 6 theme.colors.accent.primary}ee) rgba(${builtins.substring 1 6 theme.colors.accent.secondary}ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
          resize_on_border = true;
          extend_border_grab_area = 15;
          hover_icon_on_border = true;
        };

        # Layout settings
        dwindle = {
          pseudotile = true;
          preserve_split = true;
          force_split = 2;
          no_gaps_when_only = false;
        };

        # Input configuration
        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            scroll_factor = 1.0;
            tap-to-click = true;
          };
          sensitivity = 0;
          repeat_rate = 35;
          repeat_delay = 300;
          numlock_by_default = true;
        };

        # Decoration settings
        decoration = {
          rounding = theme.border.radius;
          active_opacity = 1.0;
          inactive_opacity = 0.95;
          fullscreen_opacity = 1.0;
          drop_shadow = true;
          shadow_range = 20;
          shadow_render_power = 3;
          "col.shadow" = "rgba(00000099)";
          blur = {
            enabled = true;
            size = 8;
            passes = 2;
            new_optimizations = true;
            xray = true;
            ignore_opacity = true;
          };
        };

        # Animation settings
        animations = {
          enabled = true;
          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
            "overshot, 0.13, 0.99, 0.29, 1.1"
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
          ];
          animation = [
            "windows, 1, 5, myBezier, slide"
            "windowsOut, 1, 5, smoothOut, slide"
            "windowsMove, 1, 5, smoothIn, slide"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 5, smoothIn"
            "fadeDim, 1, 5, smoothIn"
            "workspaces, 1, 6, overshot, slidevert"
          ];
        };

        # Gestures
        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
          workspace_swipe_invert = false;
          workspace_swipe_distance = 200;
          workspace_swipe_min_speed_to_force = 30;
          workspace_swipe_cancel_ratio = 0.5;
        };

        # Window/workspace rules
        windowrulev2 = [
          "opacity 0.9 0.9,class:^(ghostty)$"
          "float,class:^(pavucontrol)$"
          "float,class:^(nm-connection-editor)$"
          "float,class:^(nwg-look)$"
          "float,title:^(Picture-in-Picture)$"
          "float,title:^(Volume Control)$"
          "center,class:^(wofi)$"
          "animation slide,class:^(wofi)$" 
        ];

        # Keybindings
        bind = [
          # Applications
          "SUPER, Return, exec, ${cfg.terminal}"
          "SUPER, B, exec, ${cfg.browser}"
          "SUPER, E, exec, ${cfg.fileManager}"
          "SUPER, Space, exec, ${cfg.launcher}"
          "SUPER, C, exec, code"
          
          # Window management
          "SUPER, Q, killactive"
          "SUPER SHIFT, Q, exit"
          "SUPER, F, fullscreen, 0"
          "SUPER SHIFT, F, fullscreen, 1"
          "SUPER, V, togglefloating"
          "SUPER, P, pseudo"
          "SUPER, J, togglesplit"
          "SUPER SHIFT, S, swapnext"
          
          # Window focus
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          
          # Move windows
          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, right, movewindow, r"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, down, movewindow, d"
          
          # Resize windows
          "SUPER ALT, left, resizeactive, -20 0"
          "SUPER ALT, right, resizeactive, 20 0"
          "SUPER ALT, up, resizeactive, 0 -20"
          "SUPER ALT, down, resizeactive, 0 20"

          # Workspace navigation
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"
          
          # Move windows to workspaces
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"
          
          # Media controls
          ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
          ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
          ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          
          # Brightness controls
          ", XF86MonBrightnessUp, exec, light -A 5"
          ", XF86MonBrightnessDown, exec, light -U 5"
          
          # Screenshots
          "SUPER, Print, exec, grimblast copy area"
          ", Print, exec, grimblast copy output"
          "SHIFT, Print, exec, grimblast copy screen"
        ];

        # Mouse bindings
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        # Startup applications
        exec-once = [
          "waybar"
          "swaync"
          "nm-applet --indicator"
          "blueman-applet"
          "wl-paste --watch cliphist store"  # Clipboard history
          "hypridle"  # Screen locking
        ];
      };
    };
    
 };
} 
