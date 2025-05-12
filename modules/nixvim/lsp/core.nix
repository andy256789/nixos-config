{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.lsp = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable LSP support";
    };
    
    servers = mkOption {
      type = types.attrs;
      default = {};
      description = "LSP server configurations";
    };
    
    format = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable format on save";
      };
    };
  };

  config = mkIf (cfg.enable && cfg.lsp.enable) {
    programs.nixvim = {
      plugins = {
        lsp = {
          enable = true;
          servers = cfg.lsp.servers;
          
          keymaps = {
            silent = true;
            diagnostic = {
              # Navigate diagnostics
              "<leader>lj" = "goto_next";
              "<leader>lk" = "goto_prev";
              # Show diagnostics in floating window
              "<leader>ld" = "open_float";
              # Show diagnostics in quickfix list
              "<leader>lq" = "setloclist";
            };
            
            lspBuf = {
              # Go to definition/declaration
              "gd" = "definition";
              "gD" = "declaration";
              "gi" = "implementation";
              "gr" = "references";
              
              # Hover documentation
              "K" = "hover";
              
              # Rename symbol
              "<leader>lr" = "rename";
              
              # Code actions
              "<leader>la" = "code_action";
              
              # Format document
              "<leader>lf" = "format";
              
              # Signature help
              "<C-k>" = "signature_help";
              
              # Show type definition
              "<leader>lt" = "type_definition";
            };
          };
          
          # Customize how LSP is displayed
          capabilities = ''
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.resolveSupport = {
              properties = {
                'documentation',
                'detail',
                'additionalTextEdits',
              }
            }
            capabilities.textDocument.foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true
            }
            return capabilities
          '';
          
          onAttach = ''
            if client.server_capabilities.documentFormattingProvider then
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
                buffer = bufnr,
                callback = function()
                  if ${if cfg.lsp.format.enable then "true" else "false"} then
                    vim.lsp.buf.format()
                  end
                end,
              })
            end
          '';
        };

        # LSP server management
        mason = {
          enable = true;
          registryUrl = "https://api.mason-registry.dev/";
        };
        
        # Integrate Mason with LSP
        mason-lspconfig = {
          enable = true;
          automatic_installation = true;
        };
        
        # Signature help while typing
        lsp-signature = {
          enable = true;
          bindKey = "<C-k>";
          floatingWindow = true;
          hideInCompletion = true;
          toggleKey = "<C-x>";
        };
        
        # Code actions lightbulb
        nvim-lightbulb = {
          enable = true;
          sign = {
            enable = true;
            text = "󰌵";
          };
          virtualText = {
            enable = true;
            text = "󰌵";
          };
          autocmd = {
            enabled = true;
          };
        };
        
        # Improved LSP UI
        fidget = {
          enable = true;
          text = {
            spinner = "dots";
          };
          align = {
            bottom = true;
            right = true;
          };
          window = {
            blend = 0;
          };
        };
      };
      
      # LSP keymaps and related settings
      keymaps = [
        # LSP finder - find references, definition, implementation, etc
        {
          key = "<leader>ls";
          action = ":Telescope lsp_document_symbols<CR>";
          mode = "n";
          options = {
            desc = "Document symbols";
            silent = true;
          };
        }
        {
          key = "<leader>lS";
          action = ":Telescope lsp_workspace_symbols<CR>";
          mode = "n";
          options = {
            desc = "Workspace symbols";
            silent = true;
          };
        }
        {
          key = "<leader>li";
          action = ":LspInfo<CR>";
          mode = "n";
          options = {
            desc = "LSP info";
            silent = true;
          };
        }
        {
          key = "<leader>lI";
          action = ":Mason<CR>";
          mode = "n";
          options = {
            desc = "Mason";
            silent = true;
          };
        }
      ];
    };
  };
} 