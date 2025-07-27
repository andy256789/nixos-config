{
    config.programs.nixvim = {
        plugins.auto-session = {
            enable = true;
            settings = {
                auto_restore_enabled = false;
                auto_session_suppress_dirs = [
                    "~/"
                    "~/Dev/"
                    "~/Downloads"
                    "~/Documents"
                    "~/Desktop/"
                ];
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "<leader>wr";
                action = "<cmd>SessionRestore<CR>";
                options = { desc = "Restore session for cwd"; };
            }
            {
                mode = "n";
                key = "<leader>ws";
                action = "<cmd>SessionSave<CR>";
                options = { desc = "Save session for auto session root dir"; };
            }
        ];
    };
}
