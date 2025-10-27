-- LSP configuration
local lspconfig = require('lspconfig')

-- Nix LSP
lspconfig.nil_ls.setup({
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixfmt' },
      },
    },
  },
})

-- Lua LSP
lspconfig.lua_ls.setup({
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

-- Neovim 0.11+ provides built-in LSP keybindings:
-- K - Hover documentation
-- grn - Rename
-- gra - Code action
-- grr - References
-- gri - Implementation
-- gO - Document symbols
-- [d / ]d - Navigate diagnostics
-- <C-w>d - Floating diagnostics
