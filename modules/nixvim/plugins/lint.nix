{
    config.programs.nixvim = {
        plugins.lint = {
            enable = true;
            lintersByFt = {
                javascript = [ "biomejs" ];
                typescript = [ "biomejs" ];
                javascriptreact = [ "biomejs" ];
                typescriptreact = [ "biomejs" ];
                svelte = [ "biomejs" ];
                python = [ "pylint" ];
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>l";
                action = "<cmd>lua require('lint').try_lint()<CR>";
                options = { desc = "Trigger linting for current file"; };
            }
        ];

        autoGroups = {
            lint = { clear = true; };
        };

        autoCmd = [
            {
                event = [ "BufEnter" "BufWritePost" "InsertLeave" ];
                group = "lint";
                callback = {
                    __raw = ''
                        function()
                            require('lint').try_lint()
                        end
                    '';
                };
            }
        ];

        extraConfigLua = ''
            local lint = require("lint")
            local eslint = lint.linters.eslint_d

            eslint.args = {
                "--no-warn-ignored",
                "--format",
                "json",
                "--stdin",
                "--stdin-filename",
                function()
                    return vim.fn.expand("%:p")
                end,
            }
        '';
    };
}
