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

local augroup = vim.api.nvim_create_augroup('ClaudeCode', { clear = true })

vim.api.nvim_create_autocmd('FocusGained', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.cmd('checktime')
  end,
  desc = 'Check for file changes when Neovim gains focus',
})

-- ========================================
-- AI/CLAUDE KEYBINDINGS
-- ========================================

-- Core Operations
vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeFocus<CR>', { desc = 'AI focus terminal', silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>as', '<cmd>ClaudeCodeSend<CR>', { desc = 'AI send context', silent = true })

-- Diff Management
vim.keymap.set('n', '<leader>ad', '<cmd>ClaudeCodeDiffAccept<CR>', { desc = 'AI diff accept', silent = true })
vim.keymap.set('n', '<leader>ar', '<cmd>ClaudeCodeDiffDeny<CR>', { desc = 'AI diff reject', silent = true })

-- Optional: Model Selection
vim.keymap.set('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<CR>', { desc = 'AI model select', silent = true })
