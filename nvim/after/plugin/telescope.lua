local builtin = require('telescope.builtin')


vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leadeR>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})

vim.keymap.set('n', '<leader>rg', function()
  builtin.grep_string({
	search = vim.fn.input('Grep For > ')
  })
end, {})

vim.keymap.set('n', '<leader>fw', function()
  builtin.grep_string({
	search = vim.fn.expand('<cword>')
  })
end, {})

vim.keymap.set('n', '<C-;>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


