local lsp = require('lsp-zero')

lsp.preset("recommended")

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'gopls',
	'rust_analyzer',
	'sumneko_lua'
})

lsp.nvim_workspace()

lsp.set_preferences({
    sign_icons = { }
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
    vim.keymap.set({"n", "v"}, "ca", "<cmd>Lspsaga code_action<CR>", opts)

    vim.keymap.set('n', '<leader>e', "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)

	vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

	-- vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
