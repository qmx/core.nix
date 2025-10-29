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

      # Code outline window for skimming and quick navigation
      {
        plugin = aerial-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/aerial.lua;
      }

      # Claude Code integration
      {
        plugin = claudecode-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/claudecode.lua;
      }

      # OpenCode AI coding assistant integration
      {
        plugin = opencode-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/opencode.lua;
      }

      # Collection of small QoL plugins (required by claudecode and opencode)
      snacks-nvim

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

      # Which-key for keybinding discovery
      {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./plugins/which-key.lua;
      }

      # Required dependency for telescope
      plenary-nvim
    ];
  };
}
