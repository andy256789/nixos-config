{
  config.programs.nixvim.plugins = {
    web-devicons.enable = true;
    
    nvim-tree = {
      enable = true;
      
      # Git integration
      git = {
        enable = true;
        ignore = false;
      };
      
      # UI config
      view = {
        width = 30;
        side = "left";
        number = false;
        relativenumber = false;
      };
      
      # File filtering
      filters = {
        dotfiles = false;
        custom = [
          "^\\.git$"
          "node_modules"
          "^\\.cache$"
        ];
      };
    };
  };
} 