vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 4
vim.opt.softtabstop = 8
vim.opt.expandtab = true
vim.opt.shiftwidth = 8

vim.opt.wrap = false
-- vim.opt.undodir = "Users/benjaminkinga/.vimdid"
vim.opt.undofile = true
vim.opt.hidden = true

vim.opt.colorcolumn = "100"


local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('junegunn/fzf', { ['dir'] = '~/.fzf' })
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.6' })
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
Plug('neovim/nvim-lspconfig')
Plug('alexghergh/nvim-tmux-navigation')
Plug('RRethy/base16-nvim')
Plug('hrsh7th/nvim-cmp') -- Autocompletion plugin
Plug('hrsh7th/cmp-nvim-lsp') -- LSP source for nvim-cmp
Plug('saadparwaiz1/cmp_luasnip') -- Snippets source for nvim-cmp
Plug('L3MON4D3/LuaSnip') -- Snippets plugin
Plug('sourcegraph/sg.nvim', { ['do'] = 'nvim -l build/init.lua' })
Plug('nvim-lua/plenary.nvim')

vim.call('plug#end')

-- telescope config
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- treesitter config
require('nvim-treesitter.configs').setup {
    ensure_installed = { "rust", "lua", "javascript", "typescript", "go" },
}


vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<space>f', function()
  vim.lsp.buf.format { async = true }
end, opts)


-- autocomplete
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- lsp configs & autocompletes
local lspconfig = require('lspconfig')
lspconfig.flow.setup{
    capabilities = capabilities,
}
lspconfig.tsserver.setup{
    capabilities = capabilities,
}
lspconfig.rust_analyzer.setup{
    capabilities = capabilities,
}

lspconfig.gopls.setup { -- is all of this needed?
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

-- nvim-cmp setup
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
   snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
 --   { name = 'cody' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}


-- tmux navigation
local nvim_tmux_nav = require('nvim-tmux-navigation')

-- TODO(ben): this is very slow for some reason...
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- colorscheme
vim.cmd('colorscheme base16-tokyo-city-dark')


-- other nice keymapping
vim.keymap.set('n', "<leader><Space>", ":e #<CR>")-- go to previous buffer

-- require("sg").setup{}

vim.lsp.start({
    name = "lsp-server-example",
    cmd = {'lsp'},
    root_dir = vim.fs.dirname(vim.fs.find('example.lsp', { upward = true })[1])
})
