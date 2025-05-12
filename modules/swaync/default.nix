{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.swaync;
  theme = config.themes;
in {
  options.modules.swaync = {
    enable = mkEnableOption "Enable swaync notification daemon";
    
    position = {
      x = mkOption {
        type = types.enum [ "left" "center" "right" ];
        default = "right";
        description = "Horizontal position";
      };
      
      y = mkOption {
        type = types.enum [ "top" "center" "bottom" ];
        default = "top";
        description = "Vertical position";
      };
    };
    
    timeout = {
      default = mkOption {
        type = types.int;
        default = 10;
        description = "Default notification timeout in seconds";
      };
      
      low = mkOption {
        type = types.int;
        default = 5;
        description = "Low priority notification timeout in seconds";
      };
      
      critical = mkOption {
        type = types.int;
        default = 0;
        description = "Critical notification timeout (0 for no timeout)";
      };
    };
    
    margin = mkOption {
      type = types.int;
      default = 10;
      description = "Margin for the control center";
    };
    
    iconSize = mkOption {
      type = types.int;
      default = 64;
      description = "Notification icon size";
    };
  };

  config = mkIf cfg.enable {
    services.swaync = {
      enable = true;
      settings = {
        # Position settings
        positionX = cfg.position.x;
        positionY = cfg.position.y;
        
        # Layer settings
        layer = "overlay";
        control-center-layer = "overlay";
        layer-shell = true;
        
        # CSS settings
        cssPriority = "application";
        
        # Margin settings
        control-center-margin-top = cfg.margin;
        control-center-margin-bottom = cfg.margin;
        control-center-margin-right = cfg.margin;
        control-center-margin-left = cfg.margin;
        
        # Icon and image settings
        notification-icon-size = cfg.iconSize;
        notification-body-image-height = 100;
        notification-body-image-width = 200;
        
        # Timeout settings
        timeout = cfg.timeout.default;
        timeout-low = cfg.timeout.low;
        timeout-critical = cfg.timeout.critical;
        
        # Other settings
        fit-to-screen = true;
        relative-timestamps = true;
        show-timeout = true;
      };
      
      style = ''
        @define-color bg-color #{rgba(${builtins.substring 1 6 theme.colors.background}, ${toString theme.opacity.panel})};
        @define-color fg-color #{${theme.colors.foreground}};
        @define-color base-color #{rgba(${builtins.substring 1 6 theme.colors.background}, 0.6)};
        @define-color accent-color #{${theme.colors.accent.primary}};
        @define-color warning-color #{${theme.colors.accent.warning}};
        @define-color error-color #{${theme.colors.accent.error}};
        
        * {
          font-family: "${theme.fonts.monospace}";
          font-size: ${toString theme.fonts.size.normal}px;
        }
        
        .notification-container {
          background: transparent;
        }
        
        .notification {
          background: @bg-color;
          border-radius: ${toString theme.border.radius}px;
          margin: 5px;
          border: 2px solid @accent-color;
        }
        
        .notification-content {
          padding: 10px;
          color: @fg-color;
        }
        
        .close-button {
          border: none;
          background: @base-color;
          color: @fg-color;
          border-radius: ${toString theme.border.radius}px;
          margin: 5px;
        }
        
        .close-button:hover {
          background: @accent-color;
          color: @bg-color;
        }
        
        .control-center {
          background: @bg-color;
          border-radius: ${toString theme.border.radius}px;
          border: 2px solid @accent-color;
          padding: 10px;
        }
        
        .notification.critical {
          border: 2px solid @error-color;
        }
        
        .notification.low {
          border: 2px solid @base-color;
        }
        
        .notification-default-icon {
          color: @accent-color;
        }
        
        .notification-action-button {
          background: @base-color;
          color: @fg-color;
          border-radius: ${toString theme.border.radius}px;
          margin: 5px;
          padding: 2px 8px;
          border: none;
        }
        
        .notification-action-button:hover {
          background: @accent-color;
          color: @bg-color;
        }
        
        .control-center-list-placeholder {
          color: @fg-color;
          opacity: 0.5;
        }
      '';
    };
  };
} 