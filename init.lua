vim.opt.colorcolumn = "80" 
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.syntax = "on"
vim.g.mapleader = ' '

vim.g.loaded_netrw = 1 -- disable netrw for nvim.tree
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

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
end)

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

-- ruby lsp configuration
require('lspconfig').ruby_ls.setup({
  on_attach = function(client, buffer)
    setup_diagnostics(client, buffer)
  end,
})

vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', {})

-- telescope
require('telescope').setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.find_files, {})

-- nvimtree
require('nvim-tree').setup{}


-- TODO(ben): I think this belongs in the setup function of nvim-tree
vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', {})
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', {})
