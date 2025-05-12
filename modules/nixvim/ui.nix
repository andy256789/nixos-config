{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.nixvim;
in {
  options.modules.nixvim.ui = {
    theme = mkOption {
      type = types.str;
      default = "catppuccin";
      description = "Colorscheme to use";
    };
    
    variant = mkOption {
      type = types.enum [ "latte" "frappe" "macchiato" "mocha" ];
      default = "mocha";
      description = "Variant of the colorscheme (for supported themes)";
    };
    
    transparency = mkOption {
      type = types.bool;
      default = false;
      description = "Enable background transparency";
    };
    
    statusline = mkOption {
      type = types.enum [ "lualine" "none" ];
      default = "lualine";
      description = "Statusline plugin to use";
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
    programs.nixvim = {
      # Colorscheme setup
      colorschemes.catppuccin = {
        enable = cfg.ui.theme == "catppuccin";
        flavour = cfg.ui.variant;
        settings = {
          transparent_background = cfg.ui.transparency;
          integrations = {
            cmp = true;
            gitsigns = true;
            nvimtree = true;
            telescope.enabled = true;
            treesitter = true;
            native_lsp.enabled = true;
          };
        };
      };
      
      # Statusline
      plugins.lualine = {
        enable = cfg.ui.statusline == "lualine";
        theme = cfg.ui.theme;
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "encoding" "fileformat" "filetype" ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
      
      # Improved UI for messages, cmdline and popupmenu
      plugins.noice = {
        enable = true;
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
        };
      };
      
      plugins.nvim-notify = {
        enable = true;
        backgroundColour = "#000000";
      };

      # Buffer/tab line
      plugins.bufferline = {
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
      plugins.indent-blankline = {
        enable = cfg.ui.indentBlankline.enable;
        useTreesitter = true;
        showEndOfLine = true;
        showCurrContext = true;
      };

      # Keybinding popup helper
      plugins.which-key = {
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
      plugins.gitsigns = {
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
      plugins.treesitter = {
        enable = true;
        ensureInstalled = "all";
        disabledLanguages = [ "latex" ];
      };
    };
  };
} 