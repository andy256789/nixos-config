{
    config.programs.nixvim = {
        plugins = {
            luasnip = {
                enable = true;
                settings = {
                    enable_autosnippets = true;
                    store_selection_keys = "<Tab>";
                };
                fromVscode = [
                    {
                        lazyLoad = true;
                        paths = "~/.nix-profile/share/nvim-luasnip-friendly-snippets";
                    }
                ];
            };

            lspkind = {
                enable = true;
                symbolMap = {
                    Class = " ";
                    Color = " ";
                    Constant = " ";
                    Constructor = " ";
                    Enum = " ";
                    EnumMember = " ";
                    Event = " ";
                    Field = " ";
                    File = " ";
                    Folder = " ";
                    Function = " ";
                    Interface = " ";
                    Keyword = " ";
                    Method = " ";
                    Module = " ";
                    Operator = " ";
                    Property = " ";
                    Reference = " ";
                    Snippet = " ";
                    Struct = " ";
                    Text = " ";
                    TypeParameter = " ";
                    Unit = " ";
                    Value = " ";
                    Variable = " ";
                };
                extraOptions = {
                    maxwidth = 50;
                    ellipsis_char = "...";
                };
            };

            cmp = {
                enable = true;
                settings = {
                    auto_brackets = [ "python" ];
                    completion = { completeopt = "menu,menuone,noinsert"; };
                    experimental = { ghost_text = true; };

                    formatting = {
                        fields = [ "kind" "abbr" "menu" ];
                    };

                    mapping = {
                        "<C-k>" = "cmp.mapping.select_prev_item()";
                        "<C-j>" = "cmp.mapping.select_next_item()";
                        "<C-b>" = "cmp.mapping.scroll_docs(-4)";
                        "<C-f>" = "cmp.mapping.scroll_docs(4)";
                        "<C-Space>" = "cmp.mapping.complete()";
                        "<C-e>" = "cmp.mapping.abort()";
                        "<CR>" = "cmp.mapping.confirm({ select = false })";
                        "<Tab>" = ''
                            cmp.mapping(function(fallback)
                                if cmp.visible() then
                                    cmp.select_next_item()
                                elseif require("luasnip").expand_or_jumpable() then
                                    require("luasnip").expand_or_jump()
                                else
                                    fallback()
                                end
                            end, { "i", "s" })
                        '';
                        "<S-Tab>" = ''
                            cmp.mapping(function(fallback)
                                if cmp.visible() then
                                    cmp.select_prev_item()
                                elseif require("luasnip").jumpable(-1) then
                                    require("luasnip").jump(-1)
                                else
                                    fallback()
                                end
                            end, { "i", "s" })
                        '';
                    };

                    sources = [
                        { name = "nvim_lsp"; }
                        { name = "luasnip"; }
                        { name = "buffer"; }
                        { name = "path"; }
                    ];

                    window = {
                        completion = {
                            border = "rounded";
                            col_offset = -3;
                            side_padding = 0;
                        };
                        documentation = {
                            border = "rounded";
                        };
                    };
                };
            };

            cmp-buffer = { enable = true; };
            cmp-path = { enable = true; };
            cmp_luasnip = { enable = true; };
            cmp-nvim-lsp = { enable = true; };
        };
    };
}
