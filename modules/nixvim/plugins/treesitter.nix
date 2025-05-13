{
    config.programs.nixvim.plugins.treesitter = {
        enable = true;

        settings = {
            indent = {
                enable = true;
            };

            # Ensure these parsers are installed
            ensure_installed = [
                "bash"
                "c"
                "cpp"
                "css"
                "dockerfile"
                "go"
                "html"
                "javascript"
                "json"
                "lua"
                "markdown"
                "nix"
                "python"
                "regex"
                "rust"
                "toml"
                "tsx"
                "typescript"
                "vim"
                "yaml"
            ];
        };
    };
} 
