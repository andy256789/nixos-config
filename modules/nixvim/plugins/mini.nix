{
    config.programs.nixvim = {
        plugins = {
            # Mini comment with treesitter context
            mini = {
                enable = true;
                modules = {
                    comment = {
                        options = {
                            custom_commentstring = {
                                __raw = ''
                                    function()
                                        return vim.bo.commentstring
                                    end
                                '';
                            };
                        };
                    };
                    files = {
                        mappings = {
                            go_in = "<CR>";
                            go_in_plus = "L";
                            go_out = "-";
                            go_out_plus = "H";
                        };
                    };
                    surround = {
                        highlight_duration = 300;
                        mappings = {
                            add = "sa";
                            delete = "ds";
                            find = "sf";
                            find_left = "sF";
                            highlight = "sh";
                            replace = "sr";
                            update_n_lines = "sn";
                            suffix_last = "l";
                            suffix_next = "n";
                        };
                        n_lines = 20;
                        respect_selection_type = false;
                        search_method = "cover";
                        silent = false;
                    };
                    trailspace = {
                        only_in_normal_buffers = true;
                    };
                    splitjoin = {
                        mappings = {
                            toggle = "";
                        };
                    };
                };
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>ee";
                action = "<cmd>lua MiniFiles.open()<CR>";
                options = { desc = "Toggle mini file explorer"; };
            }
            {
                mode = "n";
                key = "<leader>ef";
                action = "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false); MiniFiles.reveal_cwd()<CR>";
                options = { desc = "Toggle into currently opened file"; };
            }
            {
                mode = "n";
                key = "<leader>cw";
                action = "<cmd>lua require('mini.trailspace').trim()<CR>";
                options = { desc = "Erase Whitespace"; };
            }
            {
                mode = [ "n" "x" ];
                key = "sj";
                action = "<cmd>lua require('mini.splitjoin').join()<CR>";
                options = { desc = "Join arguments"; };
            }
            {
                mode = [ "n" "x" ];
                key = "sk";
                action = "<cmd>lua require('mini.splitjoin').split()<CR>";
                options = { desc = "Split arguments"; };
            }
        ];

        autoCmd = [
            {
                event = "CursorMoved";
                pattern = "*";
                callback = {
                    __raw = ''
                        function()
                            pcall(function()
                                require("mini.trailspace").unhighlight()
                            end)
                        end
                    '';
                };
            }
        ];
    };
}
