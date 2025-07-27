{
    config.programs.nixvim = {
        plugins.oil = {
            enable = true;
            settings = {
                default_file_explorer = true;
                columns = [ ];
                keymaps = {
                    "<C-h>" = false;
                    "<C-c>" = false;
                    "<M-h>" = "actions.select_split";
                    "q" = "actions.close";
                };
                delete_to_trash = true;
                view_options = {
                    show_hidden = true;
                };
                skip_confirm_for_simple_edits = true;
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "-";
                action = "<cmd>Oil<CR>";
                options = { desc = "Open parent directory"; };
            }
            {
                mode = "n";
                key = "<leader>-";
                action = "<cmd>lua require('oil').toggle_float()<CR>";
                options = { desc = "Open parent directory in float"; };
            }
        ];

        autoCmd = [
            {
                event = "FileType";
                pattern = "oil";
                callback = {
                    __raw = ''
                        function()
                            vim.opt_local.cursorline = true
                        end
                    '';
                };
            }
        ];
    };
}
