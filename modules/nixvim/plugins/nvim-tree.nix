{
    config.programs.nixvim = {
        plugins = {
            web-devicons.enable = true;

            nvim-tree = {
                enable = false; # Disabled in favor of oil and mini.files
                disableNetrw = true;
                hijackNetrw = true;

                hijackDirectories = {
                    enable = false;
                    autoOpen = false;
                };

                view = {
                    width = 35;
                    side = "right";
                    number = false;
                    relativenumber = true;
                };

                renderer = {
                    indentMarkers.enable = true;
                    icons = {
                        glyphs = {
                            folder = {
                                arrowClosed = "→";
                                arrowOpen = "↓";
                            };
                        };
                    };
                };

                actions = {
                    windowPicker.enable = false;
                };

                filters = {
                    dotfiles = false;
                    custom = [ ".DS_Store" ];
                };

                git = {
                    enable = true;
                    ignore = false;
                };
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>ee";
                action = "<cmd>NvimTreeToggle<CR>";
                options = { desc = "Toggle file explorer"; };
            }
            {
                mode = "n";
                key = "<leader>ef";
                action = "<cmd>NvimTreeFindFileToggle<CR>";
                options = { desc = "Toggle file explorer on current file"; };
            }
            {
                mode = "n";
                key = "<leader>ec";
                action = "<cmd>NvimTreeCollapse<CR>";
                options = { desc = "Collapse file explorer"; };
            }
            {
                mode = "n";
                key = "<leader>er";
                action = "<cmd>NvimTreeRefresh<CR>";
                options = { desc = "Refresh file explorer"; };
            }
        ];
    };
} 
