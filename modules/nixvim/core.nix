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
    
    lineNumbers = mkOption {
      type = types.enum [ "relative" "number" "both" "none" ];
      default = "both";
      description = "Line number display mode";
    };
    
    mouse = mkOption {
      type = types.enum [ "a" "n" "v" "i" "c" "" ];
      default = "a";
      description = "Mouse mode (a=all, n=normal, v=visual, i=insert, c=command)";
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      # Set leader keys through config
      config = {
        globals = {
          mapleader = " ";
          maplocalleader = " ";
        };
      };
      
      # Set options
      options.termguicolors = true;
      options.showmode = false;
      options.signcolumn = "yes";
      options.cursorline = true;
      options.colorcolumn = cfg.colorColumn;
      options.background = "dark";
      
      options.relativenumber = (cfg.lineNumbers == "relative" || cfg.lineNumbers == "both");
      options.number = (cfg.lineNumbers == "number" || cfg.lineNumbers == "both");
      
      options.scrolloff = 8;
      options.sidescrolloff = 8;
      
      options.expandtab = true;
      options.smarttab = true;
      options.shiftwidth = cfg.tabWidth;
      options.tabstop = cfg.tabWidth;
      options.softtabstop = cfg.tabWidth;
      options.autoindent = true;
      options.smartindent = true;
      
      options.wrap = false;
      
      options.ignorecase = true;
      options.smartcase = true;
      options.hlsearch = true;
      options.incsearch = true;
      options.inccommand = "split";
      
      options.hidden = true;
      options.backup = false;
      options.swapfile = false;
      options.undofile = true;
      options.updatetime = 50;
      options.mouse = cfg.mouse;
      
      options.splitright = true;
      options.splitbelow = true;
      
      options.isfname = "+=@-@";
      
      options.clipboard = cfg.clipboard;
      
      options.backspace = [ "start" "eol" "indent" ];
      
      options.foldenable = true;
      options.foldmethod = "manual";
      options.foldlevel = 99;
    };
  };
} 