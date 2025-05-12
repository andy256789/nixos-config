{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.telescope = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Telescope fuzzy finder";
    };
  };

  config = mkIf (cfg.enable && cfg.telescope.enable) {
    programs.nixvim = {
      plugins = {
        telescope = {
          enable = true;
          defaults = {
            prompt_prefix = "   ";
            selection_caret = "  ";
            entry_prefix = "  ";
            sorting_strategy = "ascending";
            layout_strategy = "horizontal";
            layout_config = {
              horizontal = {
                prompt_position = "top";
                preview_width = 0.55;
                results_width = 0.8;
              };
              vertical = {
                mirror = false;
              };
              width = 0.87;
              height = 0.80;
              preview_cutoff = 120;
            };
            borderchars = [ "─" "│" "─" "│" "╭" "╮" "╯" "╰" ];
            set_env = { COLORTERM = "truecolor"; };
            file_ignore_patterns = [ 
              "node_modules" 
              ".git/" 
              "dist/"
              "build/"
              ".direnv/"
              "%.png"
              "%.jpg"
              "%.jpeg"
            ];
            vimgrep_arguments = [
              "${pkgs.ripgrep}/bin/rg"
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
              "--smart-case"
              "--hidden"
            ];
          };
          
          extensions = {
            fzf = {
              enable = true;
              fuzzy = true;
              overrideGenericSorter = true;
              overrideFileSorter = true;
              caseMode = "smart_case";
            };
            
            file_browser = {
              enable = true;
              theme = "ivy";
              hidden = true;
            };
            
            media_files = {
              enable = true;
              filetypes = [ "png" "jpg" "jpeg" "mp4" "webm" "pdf" ];
            };
          };
        };
      };

      # Add keymaps for Telescope
      keymaps = mkIf (cfg.telescope.enable) [
        {
          key = "<leader>ff";
          action = ":Telescope find_files<CR>";
          mode = "n";
          options = {
            desc = "Find files";
            silent = true;
          };
        }
        {
          key = "<leader>fg";
          action = ":Telescope live_grep<CR>";
          mode = "n";
          options = {
            desc = "Find text";
            silent = true;
          };
        }
        {
          key = "<leader>fb";
          action = ":Telescope buffers<CR>";
          mode = "n";
          options = {
            desc = "Find buffers";
            silent = true;
          };
        }
        {
          key = "<leader>fh";
          action = ":Telescope help_tags<CR>";
          mode = "n";
          options = {
            desc = "Find help";
            silent = true;
          };
        }
        {
          key = "<leader>fk";
          action = ":Telescope keymaps<CR>";
          mode = "n";
          options = {
            desc = "Find keymaps";
            silent = true;
          };
        }
        {
          key = "<leader>fs";
          action = ":Telescope lsp_document_symbols<CR>";
          mode = "n";
          options = {
            desc = "Find symbols";
            silent = true;
          };
        }
        {
          key = "<leader>fc";
          action = ":Telescope commands<CR>";
          mode = "n";
          options = {
            desc = "Find commands";
            silent = true;
          };
        }
      ];
    };
  };
} 