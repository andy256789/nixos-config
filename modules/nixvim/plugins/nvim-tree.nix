{
  description = "NvimTree file explorer configuration";

  config.plugins.nvim-tree = {
    enable = true;
    
    # Hijack netrw window on startup
    hijackNetrw = true;
    
    # Disable netrw completely
    disableNetrw = true;
    
    # Open tree when specifying a directory
    openOnSetup = true;
    
    # Updates the root directory of the tree on `DirChanged` event
    syncRootWithCwd = true;
    
    # Respect window splitting options
    respectWindowLayout = true;
    
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
    
    # Actions configuration
    actions = {
      openFile = {
        quitOnOpen = false;
        resize = true;
      };
    };
    
    # Renderer configuration
    renderer = {
      highlightGit = true;
      icons = {
        show = {
          git = true;
          folder = true;
          file = true;
          folderIcon = "󰝰";
        };
      };
    };
  };
} 