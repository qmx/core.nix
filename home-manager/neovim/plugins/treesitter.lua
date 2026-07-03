-- nvim-treesitter configuration
-- nvim-treesitter's old `configs` module was removed in the main-branch
-- rewrite. Highlighting is now enabled through Neovim's built-in
-- `vim.treesitter.start()` API.
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
    local ok = pcall(vim.treesitter.start, args.buf)

    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
