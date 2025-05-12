{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.languages = {
    nix = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Nix language support";
      };
    };
    
    typescript = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable TypeScript/JavaScript language support";
      };
    };
    
    rust = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Rust language support";
      };
    };
    
    go = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Go language support";
      };
    };
    
    python = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Python language support";
      };
    };
    
    lua = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Lua language support";
      };
    };
    
    html = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable HTML/CSS language support";
      };
    };
  };

  config = mkIf (cfg.enable && cfg.lsp.enable) {
    programs.nixvim.plugins.lsp.servers = 
      # Nix
      (optionalAttrs cfg.languages.nix.enable {
        nil_ls = {
          enable = true;
          settings = {
            formatting.command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
          };
        };
      }) //
      
      # TypeScript/JavaScript
      (optionalAttrs cfg.languages.typescript.enable {
        tsserver = {
          enable = true;
        };
        
        eslint = {
          enable = true;
          settings = {
            nodePath = "";
            run = "onSave";
            format = false;
          };
        };
      }) //
      
      # Rust
      (optionalAttrs cfg.languages.rust.enable {
        rust-analyzer = {
          enable = true;
          settings = {
            cargo.features = "all";
            checkOnSave = true;
            check.command = "clippy";
            procMacro.enable = true;
          };
        };
      }) //
      
      # Go
      (optionalAttrs cfg.languages.go.enable {
        gopls = {
          enable = true;
          settings = {
            usePlaceholders = true;
            analyses = {
              unusedparams = true;
              shadow = true;
            };
            staticcheck = true;
          };
        };
      }) //
      
      # Python
      (optionalAttrs cfg.languages.python.enable {
        pyright = {
          enable = true;
          settings = {
            disableOrganizeImports = false;
            analysis = {
              typeCheckingMode = "basic";
              autoSearchPaths = true;
              diagnosticMode = "workspace";
              useLibraryCodeForTypes = true;
            };
          };
        };
      }) //
      
      # Lua
      (optionalAttrs cfg.languages.lua.enable {
        lua-ls = {
          enable = true;
          settings = {
            runtime = {
              version = "LuaJIT";
            };
            diagnostics = {
              globals = [ "vim" "use" ];
            };
            workspace = {
              library = [
                "$(vim.env.VIMRUNTIME)/lua"
                "$(vim.env.VIMRUNTIME)/lua/vim/lsp"
              ];
              checkThirdParty = false;
            };
            telemetry = {
              enable = false;
            };
          };
        };
      }) //
      
      # HTML/CSS
      (optionalAttrs cfg.languages.html.enable {
        html = {
          enable = true;
        };
        
        cssls = {
          enable = true;
        };
        
        tailwindcss = {
          enable = true;
        };
      });
  };
} 