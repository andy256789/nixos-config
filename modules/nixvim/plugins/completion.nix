{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            mapping = {
              "<C-b>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.abort()";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<Tab>" = {
                action = ''
                  function(fallback)
                    if cmp.visible() then
                      cmp.select_next_item()
                    else
                      fallback()
                    end
                  end
                '';
                modes = [ "i" "s" ];
              };
              "<S-Tab>" = {
                action = ''
                  function(fallback)
                    if cmp.visible() then
                      cmp.select_prev_item()
                    else
                      fallback()
                    end
                  end
                '';
                modes = [ "i" "s" ];
              };
            };
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "buffer"; }
              { name = "path"; }
            ];
            snippet.expand = "luasnip";
            window = {
              completion = {
                border = "rounded";
                winhighlight = "Normal:CmpNormal";
              };
              documentation = {
                border = "rounded";
                winhighlight = "Normal:CmpDocNormal";
              };
            };
            formatting = {
              fields = [ "kind" "abbr" "menu" ];
              format = ''
                function(_, vim_item)
                  vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                  })[vim_item.source.name]
                  return vim_item
                end
              '';
            };
          };
        };
        
        luasnip = {
          enable = true;
          fromVscode = true;
        };
      };
    };
  };
} 