{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim = {
    lineNumbers = mkOption {
      type = types.enum [ "relative" "number" "both" "none" ];
      default = "both";
      description = "Line number display mode";
    };

    tabWidth = mkOption {
      type = types.int;
      default = 4;
      description = "Tab width in spaces";
    };

    enableAutoIndent = mkOption {
      type = types.bool;
      default = true;
      description = "Enable auto indentation";
    };

    enableSmartIndent = mkOption {
      type = types.bool;
      default = true;
      description = "Enable smart indentation";
    };

    mouse = mkOption {
      type = types.enum [ "a" "n" "v" "i" "c" "" ];
      default = "a";
      description = "Mouse mode (a=all, n=normal, v=visual, i=insert, c=command)";
    };

    showSignColumn = mkOption {
      type = types.bool;
      default = true;
      description = "Show the sign column";
    };

    clipboard = mkOption {
      type = types.enum [ "unnamedplus" "unnamed" "" ];
      default = "unnamedplus";
      description = "Clipboard register to use";
    };
    
    colorColumn = mkOption {
      type = types.str;
      default = "80";
      description = "Position to highlight with a vertical bar";
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim.globals = {
      # Disable netrw banner
      netrw_banner = 0;
      editorconfig = true;
    };

    programs.nixvim.options = {
      # Cursor appearance
      guicursor = "";
      
      # Line numbers
      relativenumber = true;
      number = true;

      # Indentation settings
      expandtab = true;     # Use spaces instead of tabs
      smarttab = true;      # Smart handling of tab key
      shiftwidth = cfg.tabWidth; 
      tabstop = cfg.tabWidth;
      softtabstop = cfg.tabWidth;
      autoindent = cfg.enableAutoIndent;
      smartindent = cfg.enableSmartIndent;
      
      # Line wrap
      wrap = false;         # Don't wrap lines

      # UI settings
      termguicolors = true; # Enable 24-bit RGB color
      showmode = false;     # Don't show mode in command line
      signcolumn = if cfg.showSignColumn then "yes" else "no";
      cursorline = true;    # Highlight current line
      scrolloff = 8;        # Keep 8 lines above/below cursor when scrolling
      sidescrolloff = 8;    # Keep 8 columns left/right of cursor when scrolling
      colorcolumn = cfg.colorColumn;
      background = "dark";
      
      # Search settings
      ignorecase = true;    # Case insensitive search
      smartcase = true;     # Unless uppercase letters are used
      hlsearch = true;      # Highlight search matches
      incsearch = true;     # Show matches while typing
      inccommand = "split"; # Preview replacements in a split

      # Behavior
      hidden = true;        # Allow switching buffers without saving
      backup = false;       # Don't create backup files
      swapfile = false;     # Don't create swap files
      undofile = true;      # Persistent undo history
      updatetime = 50;      # Faster completion
      mouse = cfg.mouse;    # Mouse support
      
      # Split window behavior
      splitright = true;    # Split vertical window to the right
      splitbelow = true;    # Split horizontal window to the bottom
      
      # File name handling
      isfname = "+=@-@";    # Add @ to filename characters
      
      # Clipboard
      clipboard = cfg.clipboard;
      
      # Backspace behavior
      backspace = [ "start" "eol" "indent" ];
      
      # Folding settings
      foldenable = true;
      foldmethod = "manual";
      foldlevel = 99;
      foldcolumn = "0";
    };
    
    programs.nixvim.extraConfigVim = ''
      let &undodir = expand("~/.vim/undodir")
    '';
  };
} 