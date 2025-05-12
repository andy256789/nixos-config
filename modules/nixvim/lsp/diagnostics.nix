{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.diagnostics = {
    icons = {
      error = mkOption {
        type = types.str;
        default = " ";
        description = "Icon for error diagnostics";
      };
      
      warn = mkOption {
        type = types.str;
        default = " ";
        description = "Icon for warning diagnostics";
      };
      
      info = mkOption {
        type = types.str;
        default = " ";
        description = "Icon for info diagnostics";
      };
      
      hint = mkOption {
        type = types.str;
        default = "󰌵 ";
        description = "Icon for hint diagnostics";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        lsp-lines = {
          enable = true;
        };
        
        trouble = {
          enable = true;
          useDiagnosticSigns = true;
        };
      };
      
      extraConfigLua = ''
        -- Configure diagnostics display
        vim.diagnostic.config({
          virtual_text = false,
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
          },
        })
        
        -- Change diagnostic symbols in the sign column
        local signs = {
          Error = "${cfg.diagnostics.icons.error}",
          Warn = "${cfg.diagnostics.icons.warn}",
          Hint = "${cfg.diagnostics.icons.hint}",
          Info = "${cfg.diagnostics.icons.info}",
        }
        
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      '';
    };
  };
} 