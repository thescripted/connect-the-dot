-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use('wbthomason/packer.nvim')

    -- utility for other packages
	use('nvim-lua/plenary.nvim')

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		'rose-pine/neovim',
		as = 'rose-pine',
	})

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('mbbill/undotree')
	use('tpope/vim-fugitive')

    use('ayu-theme/ayu-vim')
    use('christoomey/vim-tmux-navigator')

    -- file tree
    use('nvim-tree/nvim-tree.lua')

    -- copilot
    use('github/copilot.vim')

    -- LSP
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional


        -- Autocompletion
        {'hrsh7th/nvim-cmp'},         -- Required
        {'hrsh7th/cmp-nvim-lsp'},     -- Required

        -- Snippets
        {'L3MON4D3/LuaSnip'},             -- Required
      }
    }

    -- LSP Saga
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        requires = { {"nvim-tree/nvim-web-devicons"} }
    })
end)

