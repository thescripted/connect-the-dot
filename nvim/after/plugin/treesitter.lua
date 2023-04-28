require('nvim-treesitter.configs').setup {
  ensure_installed = {
	"bash", "css", "go", "html", "javascript",
	"typescript", "json", "lua",
	"python", "rust", "yaml"
  },
  sync_install = false,
  highlight = {
	enable = true,
	-- NOTE: there are mechanisms to disable highlighting for large files
  },
  indent = {
	enable = true,
  },
}
