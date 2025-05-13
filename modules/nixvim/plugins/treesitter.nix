{
  description = "Treesitter plugin configuration";

  config.plugins.treesitter = {
    enable = true;
    indent = true;
    
    # Ensure these parsers are installed
    ensureInstalled = [
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
} 