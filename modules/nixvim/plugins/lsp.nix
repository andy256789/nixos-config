{
    config.programs.nixvim = {
        plugins = {
            lsp = {
                enable = true;
                inlayHints = true;
                servers = {
                    ts_ls.enable = true;
                    lua_ls = {
                        enable = true;
                        settings = {
                            Lua = {
                                diagnostic.settings = {
                                    globals = [ "vim" ];
                                };
                                completion = {
                                    callSnippet = "Replace";
                                };
                            };
                        };
                    };
                    clangd.enable = true;
                    rust_analyzer = {
                        enable = true;
                        installCargo = true; 
                        installRustc = true;
                    };
                    nil_ls.enable = true; 
                    pyright.enable = true;
                    bashls.enable = true;
                    gopls.enable = true;
                };

                keymaps = {
                    silent = true;
                    lspBuf = {
                        gD = {
                            action = "declaration";
                            desc = "Go to declaration";
                        };
                        K = {
                            action = "hover";
                            desc = "Show documentation for what is under cursor";
                        };
                        "<leader>vca" = {
                            action = "code_action";
                            desc = "See available code actions";
                        };
                        "<leader>rn" = {
                            action = "rename";
                            desc = "Smart rename";
                        };
                        "<C-h>" = {
                            action = "signature_help";
                            desc = "Show signature help";
                            mode = "i";
                        };
                    };
                    extra = [
                        {
                            mode = "n";
                            key = "<leader>d";
                            action = "<cmd>lua vim.diagnostic.open_float()<CR>";
                            options = { desc = "Show line diagnostics"; };
                        }
                        {
                            mode = "n";
                            key = "gR";
                            action = "<cmd>Telescope lsp_references<CR>";
                            options = { desc = "Show LSP references"; };
                        }
                        {
                            mode = "n";
                            key = "gd";
                            action = "<cmd>Telescope lsp_definitions<CR>";
                            options = { desc = "Show LSP definitions"; };
                        }
                        {
                            mode = "n";
                            key = "gi";
                            action = "<cmd>Telescope lsp_implementations<CR>";
                            options = { desc = "Show LSP implementations"; };
                        }
                        {
                            mode = "n";
                            key = "gt";
                            action = "<cmd>Telescope lsp_type_definitions<CR>";
                            options = { desc = "Show LSP type definitions"; };
                        }
                        {
                            mode = "n";
                            key = "<leader>D";
                            action = "<cmd>Telescope diagnostics bufnr=0<CR>";
                            options = { desc = "Show buffer diagnostics"; };
                        }
                        {
                            mode = "n";
                            key = "<leader>rs";
                            action = ":LspRestart<CR>";
                            options = { desc = "Restart LSP"; };
                        }
                    ];
                };
            };
        };

        diagnostic = {
            settings = {
                signs = {
                    text = {
                        "1" = " ";
                        "2" = " ";
                        "3" = "󰠠 ";
                        "4" = " ";
                    };
                };
                virtual_text = true;
                underline = true;
                update_in_insert = false;
            };
        };

        extraConfigLua = ''
            -- Setup LSP keymaps for buffer when LSP attaches
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf, silent = true }
                    
                    -- Additional keymaps that use different modes
                    opts.desc = "See available code actions"
                    vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                end,
            })
        '';
    };
}
