{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  config = mkIf cfg.enable {
    programs.nixvim = {
      
      keymaps = [
        # Gitsigns mappings
        {
          key = "]c";
          action = "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'";
          mode = "n";
          options = { 
            desc = "Jump to next hunk";
            expr = true;
          };
        }
        {
          key = "[c";
          action = "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'";
          mode = "n";
          options = { 
            desc = "Jump to previous hunk";
            expr = true;
          };
        }
        
        # DiffView mappings
        {
          key = "<leader>gd";
          action = ":DiffviewOpen<CR>";
          mode = "n";
          options = { desc = "Open diffview"; };
        }
        {
          key = "<leader>gc";
          action = ":DiffviewClose<CR>";
          mode = "n";
          options = { desc = "Close diffview"; };
        }
      ];
    };
  };
} 