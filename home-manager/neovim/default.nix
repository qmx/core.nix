{ pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      nil # Nix LSP
      nixfmt-rfc-style # Nix formatter
      lua-language-server # Lua LSP
      stylua # Lua formatter
    ];

    extraLuaConfig = builtins.readFile ./init.lua;

    plugins = with pkgs.vimPlugins; [
      # Support for writing Nix expressions
      vim-nix

      # Provides mappings to easily delete, change and add surroundings in pairs
      vim-surround

      # Provides Nerd Font icons
      nvim-web-devicons

      # Fuzzy finder
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/telescope.lua;
      }

      # Git wrapper
      {
        plugin = vim-fugitive;
        type = "lua";
        config = builtins.readFile ./plugins/fugitive.lua;
      }

      # Treesitter for syntax highlighting and code navigation
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile ./plugins/treesitter.lua;
      }

      # Gruvbox color scheme
      {
        plugin = gruvbox-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/gruvbox.lua;
      }

      # Claude Code integration
      {
        plugin = claudecode-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/claudecode.lua;
      }

      # Lightweight formatter
      {
        plugin = conform-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/conform.lua;
      }

      # LSP configuration
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./plugins/lsp.lua;
      }

      # Required dependency for telescope
      plenary-nvim
    ];
  };
}
