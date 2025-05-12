{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
            "<leader>fr" = "oldfiles";
          };
          defaults = {
            file_ignore_patterns = [ "node_modules" ".git" ];
            prompt_prefix = "   ";
            selection_caret = "  ";
            mappings = {
              i = {
                "<esc>" = "close";
                "<C-j>" = "move_selection_next";
                "<C-k>" = "move_selection_previous";
              };
            };
            initial_mode = "insert";
            selection_strategy = "reset";
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
            path_display = [ "truncate" ];
          };
        };
      };
    };
  };
} 