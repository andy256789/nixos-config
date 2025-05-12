{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        # Treesitter for better syntax highlighting
        treesitter = {
          enable = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.grammarPackages; [
            bash
            c
            cpp
            css
            go
            html
            javascript
            json
            lua
            markdown
            nix
            python
            rust
            tsx
            typescript
            vim
            yaml
          ];
          incrementalSelection = {
            enable = true;
            keymaps = {
              initSelection = { __raw = "<CR>"; };
              nodeIncremental = { __raw = "<CR>"; };
              nodeDecremental = { __raw = "<BS>"; };
              scopeIncremental = { __raw = "<TAB>"; };
            };
          };
        };
        
        # Additional language tools
        nix = {
          enable = true;
          highlightStrings = true;
        };
        
        # File type plugins
        fidget = {
          enable = true;
          notification.overrideVimNotify = true;
        };
        
        nvim-colorizer = {
          enable = true;
          userDefaultOptions = {
            RGB = true;
            RRGGBB = true;
            names = true;
            RRGGBBAA = true;
            css = true;
            css_fn = true;
          };
        };
      };
    };
  };
} 