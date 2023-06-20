require("plugins")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local o = vim.opt

o.termguicolors = true
o.number = true
o.relativenumber = true
o.hlsearch = false
o.incsearch = true
o.smartcase = true
o.ignorecase = true
o.tabstop = 8
o.softtabstop = 8
o.shiftwidth = 8
o.smarttab = true
o.expandtab = false
o.smartindent = true
o.autoindent = true
o.backup = false
o.undodir = os.getenv('HOME') .. '/.vim/undodir'
o.undofile = true
o.updatetime = 50
o.wrap = false
o.scrolloff = 4
o.colorcolumn = "100"
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = false
o.signcolumn = "no"

vim.g.mapleader = " "


-- global keymaps
vim.api.nvim_set_keymap('n', '<leader>sv', ':vsplit<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sn', ':split<CR>', {noremap = true, silent = true})

-- resizing windows
vim.api.nvim_set_keymap('n', '=', ':vertical resize +5<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '-', ':vertical resize -5<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '+', ':horizontal resize +2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '_', ':horizontal resize -2<CR>', {noremap = true, silent = true})
