{
  description = "Telescope plugin configuration";

  config.plugins.telescope = {
    enable = true;
    defaults = {
      file_ignore_patterns = [
        "^.git/"
        "^node_modules/"
        "^__pycache__/"
      ];
      path_display = ["truncate"];
    };
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
    };
  };
} 