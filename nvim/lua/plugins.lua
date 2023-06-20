return require('packer').startup(function()
	-- packer
	use 'wbthomason/packer.nvim'

	-- file search
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'BurntSushi/ripgrep'
	use 'nvim-telescope/telescope-fzf-native.nvim'
	use { 'nvim-tree/nvim-tree.lua' }

	-- copilot
	use 'github/copilot.vim'

	-- lsp
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'neovim/nvim-lspconfig' }

	-- autocomplete
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	-- snippets
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'

	-- misc
        use('christoomey/vim-tmux-navigator')
	use({ 'rose-pine/neovim', as = 'rose-pine' })

	-- fugitive
	use 'tpope/vim-fugitive'

        -- harpoon
	use 'ThePrimeagen/harpoon'

	-- colorscheme
	use { "bluz71/vim-moonfly-colors", as = "moonfly" }

end)

