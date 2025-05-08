{ config, pkgs, inputs, username, ... }:

{
    home.stateVersion = "24.11";

    # Enable programs
    programs.fish.enable = true;
    programs.kitty.enable = true;

    # Hyprland configuration
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      systemd.enable = true;

      settings = {
        # General settings
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
        };

        # Decorations
        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";
        };

        # Animations
        animations = {
          enabled = true;
          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"
          ];
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # Input
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
          repeat_rate = 35;
          repeat_delay = 300;
          touchpad = {
            natural_scroll = true;
          };
        };

        # Keybindings
        bind = [
          "SUPER, Return, exec, foot" # Open terminal
          "SUPER, Q, killactive"       # Close active window
          "SUPER, B, exec, firefox"    # Open browser
          "SUPER, F, togglefloating"   # Toggle floating mode
          "SUPER, space, exec, rofi -show drun" # App launcher
          # Workspace navigation
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          # Move windows to workspaces
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
        ];

        # Mouse bindings
        bindm = [
          "SUPER, mouse:272, movewindow"   # Move window
          "SUPER, mouse:273, resizewindow" # Resize window
        ];

        # Startup programs
        exec-once = [
          "waybar" # Status bar
          "dunst"  # Notification daemon
        ];

        # Monitors (adjust as needed)
        monitor = [
          ",preferred,auto,1" # Fallback for unknown monitors
        ];
      };
    };

    # Additional packages
    home.packages = with pkgs; [
      pkgs.rofi-wayland
      pkgs.waybar
      pkgs.dunst
      pkgs.libnotify
    ];
}
