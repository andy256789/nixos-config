{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.completion = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable completion system";
    };
  };

  config = mkIf (cfg.enable && cfg.completion.enable) {
    programs.nixvim = {
      plugins = {
        # Completion engine
        nvim-cmp = {
          enable = true;
          snippet.expand = "luasnip";
          
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-n>" = {
              action = "cmp.mapping.select_next_item()";
              modes = [ "i" "s" ];
            };
            "<C-p>" = {
              action = "cmp.mapping.select_prev_item()";
              modes = [ "i" "s" ];
            };
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
            { name = "calc"; }
            { name = "treesitter"; }
            { name = "emoji"; }
          ];
          
          formatting = {
            format = ''
              require('lspkind').cmp_format({
                mode = "symbol_text",
                menu = ({
                  nvim_lsp = "[LSP]",
                  luasnip = "[Snippet]",
                  buffer = "[Buffer]",
                  path = "[Path]",
                  calc = "[Calc]",
                  treesitter = "[TS]",
                  emoji = "[Emoji]",
                }),
                maxwidth = 50,
                ellipsis_char = "...",
                before = function(_, vim_item)
                  return vim_item
                end
              })
            '';
          };
          
          experimental = {
            ghost_text = true;
          };
        };
        
        # Snippets engine
        luasnip = {
          enable = true;
          extraConfig = {
            enable_autosnippets = true;
            store_selection_keys = "<Tab>";
          };
        };
        
        # Additional completion sources
        cmp-nvim-lsp.enable = true;
        cmp-buffer.enable = true;
        cmp-path.enable = true;
        cmp-treesitter.enable = true;
        cmp-emoji.enable = true;
        cmp-calc.enable = true;
        cmp_luasnip.enable = true;
        
        # Nice icons for completion
        lspkind = {
          enable = true;
          cmp = {
            enable = true;
            menu = {
              nvim_lsp = "[LSP]";
              luasnip = "[Snippet]";
              buffer = "[Buffer]";
              path = "[Path]";
              calc = "[Calc]";
              treesitter = "[TS]";
              emoji = "[Emoji]";
            };
          };
        };
        
        # Auto pairs for brackets, parenthesis, etc.
        nvim-autopairs = {
          enable = true;
          checkTs = true;  # Use treesitter to check for pairs
        };
      };
      
      # Autoclose tags for HTML/JSX/etc.
      extraPlugins = with pkgs.vimPlugins; [
        nvim-ts-autotag
      ];
      
      # Enable autotag
      lua.extraConfig = ''
        require('nvim-ts-autotag').setup()
      '';
    };
  };
} 