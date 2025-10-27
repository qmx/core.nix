-- Conform.nvim formatter configuration
local conform = require('conform')

conform.setup({
  formatters_by_ft = {
    -- Nix files
    nix = { 'nixfmt' },

    -- Lua files
    lua = { 'stylua' },
  },

  -- Format on save
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  -- Configure formatters
  formatters = {
    stylua = {
      args = {
        '--indent-type',
        'Spaces',
        '--indent-width',
        '2',
        '--quote-style',
        'AutoPreferSingle',
        '-',
      },
    },
  },
})

-- Keybinding for manual format (recommended by conform.nvim)
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  conform.format({
    async = true,
    lsp_fallback = true,
  })
end, { desc = 'Format buffer' })
