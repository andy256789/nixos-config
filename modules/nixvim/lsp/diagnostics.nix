{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.diagnostics = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable diagnostic tools";
    };
    
    trouble = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Trouble for diagnostics";
      };
    };
    
    virtualText = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Show diagnostics as virtual text";
      };
    };
    
    signs = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Show diagnostic signs in the sign column";
      };
    };
  };

  config = mkIf (cfg.enable && cfg.lsp.enable) {
    programs.nixvim = {
      plugins = {
        # Trouble for diagnostics visualization
        trouble = mkIf cfg.diagnostics.trouble.enable {
          enable = true;
          autoClose = true;
          autoPreview = true;
          autoFold = true;
          autoOpen = false;
          mode = "document_diagnostics";
          height = 15;
          padding = true;
          icons = true;
          signs = {
            error = "";
            warning = "";
            hint = "";
            information = "";
            other = "";
          };
          
          useDefaultKeys = true;
          settings = {
            auto_jump = {
              "lsp_definitions" = false;
              "lsp_implementations" = false;
              "lsp_references" = false;
              "lsp_type_definitions" = false;
            };
          };
        };
      };

      # Configure global diagnostic settings
      extraConfigLua = ''
        -- Customize diagnostic signs
        local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }

        -- Customize diagnostic display
        vim.diagnostic.config({
          virtual_text = ${if cfg.diagnostics.virtualText.enable then "{ prefix = '● ' }" else "false"},
          signs = ${if cfg.diagnostics.signs.enable then "true" else "false"},
          update_in_insert = false,
          underline = true,
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
        
        -- Set diagnostic signs
        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      '';

      # Add keymaps for diagnostics tools
      keymaps = [
        # Trouble
        {
          key = "<leader>xx";
          action = ":TroubleToggle<CR>";
          mode = "n";
          options = {
            desc = "Toggle Trouble";
            silent = true;
          };
        }
        {
          key = "<leader>xd";
          action = ":TroubleToggle document_diagnostics<CR>";
          mode = "n";
          options = {
            desc = "Document diagnostics";
            silent = true;
          };
        }
        {
          key = "<leader>xw";
          action = ":TroubleToggle workspace_diagnostics<CR>";
          mode = "n";
          options = {
            desc = "Workspace diagnostics";
            silent = true;
          };
        }
        {
          key = "<leader>xl";
          action = ":TroubleToggle loclist<CR>";
          mode = "n";
          options = {
            desc = "Location list";
            silent = true;
          };
        }
        {
          key = "<leader>xq";
          action = ":TroubleToggle quickfix<CR>";
          mode = "n";
          options = {
            desc = "Quickfix list";
            silent = true;
          };
        }
        {
          key = "<leader>xr";
          action = ":TroubleToggle lsp_references<CR>";
          mode = "n";
          options = {
            desc = "LSP references";
            silent = true;
          };
        }
      ];
    };
  };
} 