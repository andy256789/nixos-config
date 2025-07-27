{
    config.programs.nixvim = {
        autoCmd = [
            {
                event = "FileType";
                pattern = "markdown";
                callback = {
                    __raw = ''
                        function()
                            vim.opt_local.textwidth = 80
                            vim.opt_local.spell = true
                            vim.opt_local.linebreak = true
                        end
                    '';
                };
            }
            {
                event = "FileType";
                pattern = "python";
                callback = {
                    __raw = ''
                        function()
                            vim.opt_local.tabstop = 4
                            vim.opt_local.shiftwidth = 4
                            vim.opt_local.softtabstop = 4
                            vim.opt_local.expandtab = true
                        end
                    '';
                };
            }
            {
                event = "FileType";
                pattern = [ "typescriptreact" "javascriptreact" ];
                callback = {
                    __raw = ''
                        function()
                            vim.opt_local.tabstop = 2
                            vim.opt_local.shiftwidth = 2
                            vim.opt_local.softtabstop = 2
                            vim.opt_local.expandtab = true
                        end
                    '';
                };
            }
        ];
    };
}
