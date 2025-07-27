{
    config.programs.nixvim = {
        # Disable netrw banner
        globals = {
            netrw_banner = 0;
            editorconfig = true;
        };

        # General cursor and display settings
        opts = {
            # Cursor
            guicursor = "a:block";

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
            undodir = "/home/andy/.vim/undodir";
            undofile = true;

            # Search
            incsearch = true;
            inccommand = "split";
            ignorecase = true;
            smartcase = true;
            hlsearch = true;

            # Colors
            termguicolors = true;
            background = "dark";

            # UI
            scrolloff = 8;
            signcolumn = "yes";
            colorcolumn = "80";
            
            # Transparency and blend
            winblend = 0;
            pumblend = 0;

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
            clipboard = {
                providers = {
                    wl-copy.enable = true; # Wayland 
                };
                register = "unnamedplus";
            };
            # Mouse
            mouse = "a";
        };
    };
} 
