require("rose-pine").setup()
vim.cmd('colorscheme rose-pine')


-- LSP Config
local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = false,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})


-- LSP Saga
require("lspsaga").setup({
    lightbulb = {
        enable = false,
        enable_in_insert = false,
    },
    ui = {
        title = false,
    },
    symbol_in_winbar = {
        enable = false,
    },
    beacon = {
        enable = false
    }
})

-- LSP Binding on buffer
lsp.on_attach(function(client, bufnr)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
    vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    vim.keymap.set("n","gd", "<cmd>Lspsaga goto_definition<CR>", opts)
    vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>", opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)

end)


lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
