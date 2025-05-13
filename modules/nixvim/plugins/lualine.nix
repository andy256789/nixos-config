{
  config.programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        theme = "tokyonight";
        component_separators = {
          left = "|";
          right = "|";
        };
        section_separators = {
          left = "";
          right = "";
        };
      };
      
      sections = {
        lualine_a = ["mode"];
        lualine_b = [
          "branch"
          {
            name = "diff";
            symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
          }
        ];
        lualine_c = [
          {
            name = "filename";
            fileSizeColor = "Status_Line";
            symbols = {
              modified = " ";
              readonly = " ";
              unnamed = "[No Name]";
              newfile = "[New]";
            };
          }
        ];
        lualine_x = ["encoding" "fileformat" "filetype"];
        lualine_y = ["progress"];
        lualine_z = ["location"];
      };
      
      tabline = {};
      
      extensions = ["nvim-tree" "fugitive"];
    };
  };
} 