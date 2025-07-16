{
    config.programs.nixvim.plugins = {
        lsp = {
            enable = true;
            inlayHints = true;
            servers = {
                ts_ls.enable = true;
                lua_ls.enable = true;
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

        # Autocompletion setup
        cmp = {
            enable = true;
            autoEnableSources = true;
            
            sources = [
                { name = "nvim_lsp"; }
                { name = "path"; }
                { name = "buffer"; }
                { name = "luasnip"; }
            ];

            settings = {
                formatting = {
                    format = ''
                        function(entry, vim_item)
                            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                            vim_item.menu = ({
                                buffer = "[Buffer]",
                                nvim_lsp = "[LSP]",
                                luasnip = "[LuaSnip]",
                                path = "[Path]",
                            })[entry.source.name]
                            return vim_item
                        end
                    '';
                };

                mapping = {
                    "<C-k>" = "cmp.mapping.select_prev_item()";
                    "<C-j>" = "cmp.mapping.select_next_item()";
                    "<C-b>" = "cmp.mapping.scroll_docs(-4)";
                    "<C-f>" = "cmp.mapping.scroll_docs(4)";
                    "<C-Space>" = "cmp.mapping.complete()";
                    "<C-e>" = "cmp.mapping.abort()";
                    "<CR>" = "cmp.mapping.confirm({ select = true })";
                    "<Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, {'i', 's'})";
                    "<S-Tab>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, {'i', 's'})";
                };
            };
        };

        # Completion sources
        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp-path.enable = true;
        cmp_luasnip.enable = true;

        # Snippet engine (required for nvim-cmp)
        luasnip.enable = true;
        friendly-snippets.enable = true;
    };
}
