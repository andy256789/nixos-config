{
    config.programs.nixvim = {
        plugins.trouble = {
            enable = true;
            settings = {
                focus = true;
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>xw";
                action = "<cmd>Trouble diagnostics toggle<CR>";
                options = { desc = "Open trouble workspace diagnostics"; };
            }
            {
                mode = "n";
                key = "<leader>xd";
                action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
                options = { desc = "Open trouble document diagnostics"; };
            }
            {
                mode = "n";
                key = "<leader>xq";
                action = "<cmd>Trouble quickfix toggle<CR>";
                options = { desc = "Open trouble quickfix list"; };
            }
            {
                mode = "n";
                key = "<leader>xl";
                action = "<cmd>Trouble loclist toggle<CR>";
                options = { desc = "Open trouble location list"; };
            }
            {
                mode = "n";
                key = "<leader>xt";
                action = "<cmd>Trouble todo toggle<CR>";
                options = { desc = "Open todos in trouble"; };
            }
        ];
    };
}
