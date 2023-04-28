return require('packer').startup(function()
	-- packer
	use 'wbthomason/packer.nvim'

	-- file search
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'BurntSushi/ripgrep'
	use 'nvim-telescope/telescope-fzf-native.nvim'

	-- copilot
	use 'github/copilot.vim'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use { 'neovim/nvim-lspconfig' }

	use { 'nvim-tree/nvim-tree.lua' }
    use('christoomey/vim-tmux-navigator')

	use({ 'rose-pine/neovim', as = 'rose-pine' })
end)
