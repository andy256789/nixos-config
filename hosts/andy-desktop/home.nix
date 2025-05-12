{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.stateVersion = "24.11";

  # Enable themes with default settings
  themes.enable = true;

  # Enable modules with customizations
  modules = {
    hyprland = {
      enable = true;
      terminal = "ghostty";
      browser = "firefox";
      fileManager = "nemo";
    };
    
    waybar.enable = true;
    
    gtk = {
      enable = true;
      iconTheme = "Papirus-Dark";
      cursorTheme = "Bibata-Modern-Ice";
    };
    
    wallpapers = {
      enable = true;
      wallpaper = "anime-cyberpunk.png";
      transition = "wipe";
      transitionStep = 90;
      transitionDuration = 4;
    };
    
    packages = {
      enable = true;
      terminal.enable = true;
      fileManagers.enable = true;
      development.enable = true;
      browsers.enable = true;
      media.enable = true;
      utilities.enable = true;
      communication.enable = true;
    };
    
    ghostty = {
      enable = true;
      fontSize = 12;
      paddingX = 10;
      paddingY = 10;
      cursorStyle = "bar";
    };
    
    swaync = {
      enable = true;
      position = {
        x = "right";
        y = "top";
      };
      timeout = {
        default = 10;
        low = 5;
        critical = 0;
      };
      margin = 10;
      iconSize = 64;
    };

    # NixVim Configuration
    nixvim = {
      enable = true;

      # Editor options
      lineNumbers = "both";
      tabWidth = 4;
      mouse = "a";
      
      # Colorscheme options
      colorscheme = {
        name = "catppuccin";
        variant = "auto"; # Will follow system theme
        transparent = false;
      };
      
      # UI components
      ui = {
        statusline = {
          enable = true;
          plugin = "lualine";
        };
        bufferline.enable = true;
        indentBlankline.enable = true;
        whichkey.enable = true;
      };
      
      # File Explorer
      fileExplorer = {
        enable = true;
        type = "neo-tree";
      };
      
      # Fuzzy finder
      telescope.enable = true;
      
      # Git integration
      git.enable = true;
      
      # Completion system
      completion.enable = true;
      
      # Editing enhancements
      editing = {
        enable = true;
        commentToggle.enable = true;
        surround.enable = true;
        formatting.enable = true;
      };
      
      # LSP support
      lsp = {
        enable = true;
        format.enable = true;
        
        # Configure language servers
        servers = { };
      };
      
      # Language support
      languages = {
        nix.enable = true;
        typescript.enable = true;
        rust.enable = true;
        go.enable = true;
        python.enable = true;
        lua.enable = true;
        html.enable = true;
      };
      
      # Diagnostics
      diagnostics = {
        enable = true;
        trouble.enable = true;
        virtualText.enable = true;
        signs.enable = true;
      };
    };
  };

  # Enable programs
  programs = {
    fish.enable = true;
  };

  # Enable services
  services = {
    network-manager-applet.enable = true;
  };
}
