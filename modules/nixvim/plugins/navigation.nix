{
    config.programs.nixvim = {
        plugins = {
            # Plenary - lua utility functions used by many plugins
            neotest = {
                enable = true;
                adapters = {
                    plenary = {
                        enable = true;
                    };
                };
            };
            
            # Tmux navigator for seamless navigation between vim splits and tmux panes
            tmux-navigator.enable = true;
        };
    };
}
