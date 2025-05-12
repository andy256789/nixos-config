{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim = {
    tabWidth = mkOption {
      type = types.int;
      default = 2;
      description = "Tab width in spaces";
    };
    
    colorColumn = mkOption {
      type = types.str;
      default = "80";
      description = "Position to highlight with a vertical bar";
    };
    
    clipboard = mkOption {
      type = types.enum [ "unnamedplus" "unnamed" "" ];
      default = "unnamedplus";
      description = "Clipboard register to use";
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
      
      options = {
        # Appearance
        termguicolors = true;
        showmode = false;
        signcolumn = "yes";
        cursorline = true;
        colorcolumn = cfg.colorColumn;
        background = "dark";
        
        # Line numbers
        relativenumber = true;
        number = true;
        
        # Scrolling
        scrolloff = 8;
        sidescrolloff = 8;
        
        # Indentation
        expandtab = true;
        smarttab = true;
        shiftwidth = cfg.tabWidth;
        tabstop = cfg.tabWidth;
        softtabstop = cfg.tabWidth;
        autoindent = true;
        smartindent = true;
        
        # Line wrap
        wrap = false;
        
        # Search
        ignorecase = true;
        smartcase = true;
        hlsearch = true;
        incsearch = true;
        inccommand = "split";
        
        # Behavior
        hidden = true;
        backup = false;
        swapfile = false;
        undofile = true;
        updatetime = 50;
        mouse = "a";
        
        # Split windows
        splitright = true;
        splitbelow = true;
        
        # Filename handling
        isfname = "+=@-@";
        
        # Clipboard integration
        clipboard = cfg.clipboard;
        
        # Backspace behavior
        backspace = [ "start" "eol" "indent" ];
        
        # Folding settings
        foldenable = true;
        foldmethod = "manual";
        foldlevel = 99;
      };
    };
  };
} 