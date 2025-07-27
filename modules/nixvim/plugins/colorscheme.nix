{
    config.programs.nixvim = {
        colorschemes.rose-pine = {
            enable = true;
            settings = {
                variant = "main";
                dark_variant = "main";
                dim_inactive_windows = false;
                styles = {
                    bold = true;
                    italic = false;
                    transparency = true;
                };
                highlight_groups = {
                    ColorColumn = { bg = "#1C1C21"; };
                    Normal = { bg = "none"; };
                    Pmenu = { bg = ""; fg = "#e0def4"; };
                    PmenuSel = { bg = "#4a465d"; fg = "#f8f5f2"; };
                    PmenuSbar = { bg = "#191724"; };
                    PmenuThumb = { bg = "#9ccfd8"; };
                };
                enable = {
                    terminal = false;
                    legacy_highlights = false;
                    migrations = true;
                };
            };
        };

        # Also enable gruvbox as alternative
        colorschemes.gruvbox = {
            enable = false;
            settings = {
                terminal_colors = true;
                undercurl = true;
                underline = true;
                bold = true;
                italic = {
                    strings = true;
                    emphasis = true;
                    comments = true;
                    operators = false;
                    folds = true;
                };
                strikethrough = true;
                invert_selection = false;
                invert_signs = false;
                invert_tabline = false;
                invert_intend_guides = false;
                inverse = true;
                contrast = "";
                palette_overrides = {};
                overrides = {};
                dim_inactive = false;
                transparent_mode = false;
            };
        };
    };
} 
