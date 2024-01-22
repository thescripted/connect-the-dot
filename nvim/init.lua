vim.opt.colorcolumn = "80" 
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.syntax = "on"
vim.g.mapleader = ' '
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.g.loaded_netrw = 1 -- disable netrw for nvim.tree
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true -- nvim-tree highlight groups

-- packer
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.2',
	-- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'neovim/nvim-lspconfig'
	use 'github/copilot.vim'
	use 'nvim-tree/nvim-tree.lua'
	use 'christoomey/vim-tmux-navigator'

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'

  use 'Shatur/neovim-ayu'
  use { 'prettier/vim-prettier' }
end)

-- colorscheme
require('ayu').colorscheme()

-- TOOD(ben): keymaps for buffer traversal

-- telescope
require('telescope').setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})

-- nvimtree
require('nvim-tree').setup{
	view = {
		width = {}
	},
  filters = {
    git_ignored = false,
  },
}

-- treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
}

-- TODO(ben): prettier


-- TODO(ben): I think this belongs in the setup function of nvim-tree
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', {})

--
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- textDocument/diagnostic support until 0.10.0 is released
_timers = {}
local function setup_diagnostics(client, buffer)
  if require("vim.lsp.diagnostic")._enable then
    return
  end

  local diagnostic_handler = function()
    local params = vim.lsp.util.make_text_document_params(buffer)
    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
      if err then
        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
        vim.lsp.log.error(err_msg)
      end
      if not result then
        return
      end
      vim.lsp.diagnostic.on_publish_diagnostics(
        nil,
        vim.tbl_extend("keep", params, { diagnostics = result.items }),
        { client_id = client.id }
      )
    end)
  end

  diagnostic_handler() -- to request diagnostics on buffer when first attaching

  vim.api.nvim_buf_attach(buffer, false, {
    on_lines = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
    end,
    on_detach = function()
      if _timers[buffer] then
        vim.fn.timer_stop(_timers[buffer])
      end
    end,
  })
end

-- lsp configuration
require('lspconfig').ruby_ls.setup({
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
  end,
  capabilities = capabilities
})
require('lspconfig').tsserver.setup({
	capabilities = capabilities
})
require('lspconfig').gopls.setup({
	capabilities = capabilities
})

-- TODO(ben): maybe we can remove this
require('lspconfig').eslint.setup({
	on_attach = function(client, buffer)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	capabilities = capabilities
})
require('lspconfig').pyright.setup({
	capabilities = capabilities
})

-- keybindings for lsp
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, {})
vim.keymap.set('n', 'ca', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {})
