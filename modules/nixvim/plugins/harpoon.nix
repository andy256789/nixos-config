{
    config.programs.nixvim = {
        plugins.harpoon = {
            enable = true;
            enableTelescope = true;
            settings = {
                global_settings = {
                    save_on_toggle = true;
                    save_on_change = true;
                };
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>a";
                action = "<cmd>lua require('harpoon'):list():add()<CR>";
                options = { desc = "Harpoon add file"; };
            }
            {
                mode = "n";
                key = "<C-e>";
                action = "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<CR>";
                options = { desc = "Harpoon quick menu"; };
            }
            {
                mode = "n";
                key = "<C-y>";
                action = "<cmd>lua require('harpoon'):list():select(1)<CR>";
                options = { desc = "Harpoon goto file 1"; };
            }
            {
                mode = "n";
                key = "<C-t>";
                action = "<cmd>lua require('harpoon'):list():select(2)<CR>";
                options = { desc = "Harpoon goto file 2"; };
            }
            {
                mode = "n";
                key = "<C-n>";
                action = "<cmd>lua require('harpoon'):list():select(3)<CR>";
                options = { desc = "Harpoon goto file 3"; };
            }
            {
                mode = "n";
                key = "<C-s>";
                action = "<cmd>lua require('harpoon'):list():select(4)<CR>";
                options = { desc = "Harpoon goto file 4"; };
            }
        ];
    };
}
