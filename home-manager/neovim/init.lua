-- Basic Neovim settings

-- Set leader key to comma
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- UI
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.wrap = true
vim.opt.linebreak = true

-- Editing
vim.opt.undofile = true
vim.opt.backup = false
vim.opt.swapfile = false

-- Clipboard
vim.opt.clipboard = 'unnamedplus'
