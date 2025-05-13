{
  config = {
    # Disable netrw banner
    globals = {
      netrw_banner = 0;
    };

    # General cursor and display settings
    opts = {
      # Cursor
      guicursor = "";

      # Numbers
      number = true;
      relativenumber = true;

      # Indentation
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      wrap = false;

      # Files
      swapfile = false;
      backup = false;
      undofile = true;
      undodir = "$HOME/.vim/undodir";

      # Search
      incsearch = true;
      inccommand = "split";
      ignorecase = true;
      smartcase = true;
      hlsearch = true;

      # Colors
      termguicolors = true;
      background = "dark";
      colorcolumn = "80";

      # UI
      scrolloff = 8;
      signcolumn = "yes";

      # Folding
      foldenable = true;
      foldmethod = "manual";
      foldlevel = 99;
      foldcolumn = "0";

      # Backspace behavior
      backspace = ["start" "eol" "indent"];

      # Window splitting
      splitright = true;
      splitbelow = true;

      # File path
      isfname.append = "@-@";
      
      # Performance
      updatetime = 50;

      # Clipboard
      clipboard.append = "unnamedplus";

      # Mouse
      mouse = "a";
    };

    # EditorConfig support
    globals.editorconfig = true;
  };
} 