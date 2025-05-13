{
  description = "LSP configuration";

  config.plugins = {
    lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        lua-ls.enable = true;
        rust-analyzer.enable = true;
        nil-ls.enable = true; # Nix language server
        gopls.enable = true;
        pyright.enable = true;
        bashls.enable = true;
      };
      
      keymaps = {
        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "gr" = "references";
          "gi" = "implementation";
          "K" = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
        };
        diagnostic = {
          "<leader>d" = "open_float";
          "[d" = "goto_prev";
          "]d" = "goto_next";
        };
      };
    };

    none-ls = {
      enable = true;
      sources = {
        formatting = {
          prettier.enable = true;
          black.enable = true;
          nixpkgs_fmt.enable = true;
          stylua.enable = true;
          rustfmt.enable = true;
          gofmt.enable = true;
          shfmt.enable = true;
        };
        diagnostics = {
          eslint.enable = true;
          shellcheck.enable = true;
        };
      };
    };

    lsp-format.enable = true;
    
    nvim-cmp = {
      enable = true;
      
      mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = {
          action = "cmp.mapping.select_prev_item()";
          modes = ["i" "s"];
        };
        "<Tab>" = {
          action = "cmp.mapping.select_next_item()";
          modes = ["i" "s"];
        };
      };
      
      sources = [
        { name = "nvim_lsp"; }
        { name = "buffer"; }
        { name = "path"; }
        { name = "luasnip"; }
      ];
    };
    
    luasnip.enable = true;
  };
} 