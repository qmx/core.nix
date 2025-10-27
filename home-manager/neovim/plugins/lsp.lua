-- LSP configuration using vim.lsp.config (Neovim 0.11+)

-- Nix LSP
vim.lsp.config('nil_ls', {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', '.git' },
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixfmt' },
      },
    },
  },
})
vim.lsp.enable('nil_ls')

-- Lua LSP
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable('lua_ls')

-- Neovim 0.11+ provides built-in LSP keybindings:
-- K - Hover documentation
-- grn - Rename
-- gra - Code action
-- grr - References
-- gri - Implementation
-- gO - Document symbols
-- [d / ]d - Navigate diagnostics
-- <C-w>d - Floating diagnostics
