-- Claude Code integration
local claudecode = require('claudecode')

claudecode.setup({
  diff_opts = {
    layout = "horizontal",
  },
  terminal = {
    split_side = 'left',
    split_width_percentage = 0.50,
  },
})

-- Auto-check for file changes when Neovim gains focus
local augroup = vim.api.nvim_create_augroup('ClaudeCode', { clear = true })
vim.api.nvim_create_autocmd('FocusGained', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.cmd('checktime')
  end,
  desc = 'Check for file changes when Neovim gains focus',
})
