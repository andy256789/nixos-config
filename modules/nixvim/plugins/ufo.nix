{
    config.programs.nixvim = {
        plugins.nvim-ufo = {
            enable = true;
            settings = {
                provider_selector = ''
                    function(_, _, _)
                        return { "treesitter", "indent" }
                    end
                '';
                open_fold_hl_timeout = 0;
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "zR";
                action = "<cmd>lua require('ufo').openAllFolds()<CR>";
                options = { desc = "Open all folds"; };
            }
            {
                mode = "n";
                key = "zM";
                action = "<cmd>lua require('ufo').closeAllFolds()<CR>";
                options = { desc = "Close all folds"; };
            }
        ];

        extraConfigLua = ''
            vim.o.foldcolumn = '0'
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
        '';
    };
}
