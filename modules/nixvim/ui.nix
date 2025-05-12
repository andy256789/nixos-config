{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.ui = {
    statusline = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable status line";
      };
      
      plugin = mkOption {
        type = types.enum [ "lualine" "airline" ];
        default = "lualine";
        description = "Statusline plugin to use";
      };
    };
    
    bufferline = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable buffer line";
      };
    };
    
    indentBlankline = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable indent guides";
      };
    };
    
    whichkey = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable which-key for keybinding help";
      };
    };
  };

  config = mkIf cfg.enable {
    # Status line
    programs.nixvim.plugins.lualine = {
      enable = cfg.ui.statusline.enable && cfg.ui.statusline.plugin == "lualine";
      theme = "auto";
      componentSeparators = {
        left = "|";
        right = "|";
      };
      sectionSeparators = {
        left = "";
        right = "";
      };
      globalstatus = true;
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" "diff" "diagnostics" ];
        lualine_c = [ "filename" ];
        lualine_x = [ "encoding" "fileformat" "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
    };

    programs.nixvim.plugins.airline = {
      enable = cfg.ui.statusline.enable && cfg.ui.statusline.plugin == "airline";
      powerline = true;
      theme = "auto";
    };

    # Buffer/tab line
    programs.nixvim.plugins.bufferline = {
      enable = cfg.ui.bufferline.enable;
      diagnostics = "nvim_lsp";
      closeIcon = "";
      modifiedIcon = "●";
      bufferCloseIcon = "";
      alwaysShowBufferline = false;
      separatorStyle = "slant";
      showBufferCloseIcons = true;
      showCloseIcon = false;
    };

    # Indent guides
    programs.nixvim.plugins.indent-blankline = {
      enable = cfg.ui.indentBlankline.enable;
      useTreesitter = true;
      showEndOfLine = true;
      showCurrContext = true;
    };

    # Keybinding popup helper
    programs.nixvim.plugins.which-key = {
      enable = cfg.ui.whichkey.enable;
      registrations = {
        "<leader>f" = "Find/Files";
        "<leader>g" = "Git";
        "<leader>l" = "LSP";
        "<leader>t" = "Toggle";
        "<leader>w" = "Windows";
      };
    };

    # Git signs in gutter
    programs.nixvim.plugins.gitsigns = {
      enable = true;
      signs = {
        add = { text = "▎"; };
        change = { text = "▎"; };
        delete = { text = ""; };
        topdelete = { text = ""; };
        changedelete = { text = "▎"; };
        untracked = { text = "▎"; };
      };
    };

    # Enhanced syntax highlighting
    programs.nixvim.plugins.treesitter = {
      enable = true;
      ensureInstalled = "all";
      disabledLanguages = [ "latex" ];
    };

    # Improved UI components
    programs.nixvim.plugins.noice = {
      enable = true;
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
        inc_rename = false;
        lsp_doc_border = true;
      };
    };

    # Notification system
    programs.nixvim.plugins.notify = {
      enable = true;
      backgroundColour = "#000000";
      timeout = 3000;
      topDown = true;
      maxWidth = 50;
      maxHeight = 20;
      stages = "fade";
    };
  };
} 