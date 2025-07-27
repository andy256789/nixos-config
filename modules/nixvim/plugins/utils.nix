{
    config.programs.nixvim = {
        plugins = {
            nvim-autopairs = {
                enable = true;
                settings = {
                    check_ts = true;
                    ts_config = {
                        lua = [ "string" ];
                        javascript = [ "template_string" ];
                        java = false;
                    };
                };
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>sm";
                action = "<cmd>MaximizerToggle<CR>";
                options = { desc = "Maximize/minimize a split"; };
            }
        ];
    };
}
