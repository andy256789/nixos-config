{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  imports = [
    ./languages.nix
    ./diagnostics.nix
  ];
  
  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        lsp = {
          enable = true;
          servers = {
            lua-ls.enable = true;
            nil-ls.enable = true;
            rust-analyzer.enable = true;
            tsserver.enable = true;
          };
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
            lspBuf = {
              "gd" = "definition";
              "gD" = "declaration";
              "gi" = "implementation";
              "gt" = "type_definition";
              "gr" = "references";
              "K" = "hover";
              "<leader>rn" = "rename";
              "<leader>ca" = "code_action";
            };
          };
        };
      };
    };
  };
} 