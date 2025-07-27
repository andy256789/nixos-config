{
    config.programs.nixvim = {
        plugins.telescope = {
            enable = true;
            extensions = {
                fzf-native = {
                    enable = true;
                    settings = {
                        fuzzy = true;
                        override_generic_sorter = true;
                        override_file_sorter = true;
                        case_mode = "smart_case";
                    };
                };
            };
            settings = {
                defaults = {
                    file_ignore_patterns = [
                        "^.git/"
                        "^node_modules/"
                        "^__pycache__/"
                    ];
                    path_display = [ "smart" ];
                    mappings = {
                        i = {
                            "<C-k>" = "move_selection_previous";
                            "<C-j>" = "move_selection_next";
                        };
                    };
                };
            };
            keymaps = {
                "<leader>ff" = "find_files";
                "<leader>fg" = "live_grep";
                "<leader>fb" = "buffers";
                "<leader>fh" = "help_tags";
                "<leader>pr" = "oldfiles";
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>pWs";
                action = "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cWORD>') })<CR>";
                options = { desc = "Find Connected Words under cursor"; };
            }
        ];
    };
} 
