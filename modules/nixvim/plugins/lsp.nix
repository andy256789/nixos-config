{
    config.programs.nixvim.plugins = {
        lsp = {
            enable = true;
            inlayHints = true;
            servers = {
                ts_ls.enable = true;
                lua_ls.enable = true;
                rust_analyzer = {
                    enable = true;
                    installCargo = true; 
                    installRustc = true;
                };
                nil_ls.enable = true; # Nix language server
                pyright.enable = true;
                bashls.enable = true;
                gopls.enable = true;
            };

            keymaps = {
                silent = true;
                lspBuf = {
                    gd = {
                        action = "definition";
                        desc = "Goto Definition";
                    };
                    gr = {
                        action = "references";
                        desc = "Goto References";
                    };
                    gD = {
                        action = "declaration";
                        desc = "Goto Declaration";
                    };
                    gI = {
                        action = "implementation";
                        desc = "Goto Implementation";
                    };
                    gT = {
                        action = "type_definition";
                        desc = "Type Definition";
                    };
                };
            };
        };

        lsp-format.enable = true;
    };
} 
