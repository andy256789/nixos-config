{
    config.programs.nixvim = {
        plugins.todo-comments = {
            enable = true;
            settings = {
                keywords = {
                    FIX = {
                        icon = " ";
                        color = "error";
                        alt = [ "FIXME" "BUG" "FIXIT" "ISSUE" ];
                    };
                    TODO = {
                        icon = " ";
                        color = "info";
                    };
                    HACK = {
                        icon = " ";
                        color = "warning";
                        alt = [ "DON SKIP" ];
                    };
                    WARN = {
                        icon = " ";
                        color = "warning";
                        alt = [ "WARNING" "XXX" ];
                    };
                    PERF = {
                        icon = " ";
                        alt = [ "OPTIM" "PERFORMANCE" "OPTIMIZE" ];
                    };
                    NOTE = {
                        icon = " ";
                        color = "hint";
                        alt = [ "INFO" "READ" "COLORS" ];
                    };
                    TEST = {
                        icon = "⏲ ";
                        color = "test";
                        alt = [ "TESTING" "PASSED" "FAILED" ];
                    };
                };
            };
        };

        keymaps = [
            {
                mode = "n";
                key = "]t";
                action = "<cmd>lua require('todo-comments').jump_next()<CR>";
                options = { desc = "Next todo comment"; };
            }
            {
                mode = "n";
                key = "[t";
                action = "<cmd>lua require('todo-comments').jump_prev()<CR>";
                options = { desc = "Previous todo comment"; };
            }
        ];
    };
}
