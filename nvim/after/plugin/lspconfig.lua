require('lspconfig').gopls.setup{}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').tsserver.setup{}

-- global mapping
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
	-- enable completion triggered by <c-x><c-o>
	vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

	local opts = { buffer = ev.buf }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', '<leader><C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', '<leader>f', function()
	    vim.lsp.buf.format { async = true }
	end, opts)
    end,
})
