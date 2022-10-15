set smartindent
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch " TODO(ben): fix this
set termguicolors
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set colorcolumn=100
set signcolumn=yes
set cursorline


" TODO(ben): add undotree, fugitive, maybe treesitter

call plug#begin()
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig' " TODO(ben): set this up
Plug 'ayu-theme/ayu-vim'
Plug 'gruvbox-community/gruvbox'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/vim-vsnip'
Plug 'tpope/vim-fugitive'
Plug 'ray-x/lsp_signature.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'folke/tokyonight.nvim'
Plug 'preservim/nerdtree'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'tpope/vim-commentary'
call plug#end()

let g:NERDTreeWinSize=60
let g:tokyonight_style="night" " Must be before colorscheme
colorscheme tokyonight 

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

lua << EOF
-- Tokyonight config after colorscheme
vim.g.tokyonight_colors = {
  border = '#1A1B26';
}
vim.highlight.create('CursorLineNR', { guifg = "Yellow", ctermfg = "Yellow", guibg = "None", cterm = "bold" }, false);
vim.highlight.create('colorcolumn', { guibg = "Grey" }, false);

vim.highlight.link('LineNr', 'Comment', true)
vim.highlight.create('NormalFloat', { guibg = "None", guifg = "None" }, false);
vim.highlight.create('FloatBorder', { guibg = "None" }, false);
vim.highlight.create('WhichKeyFloat', { guibg = "None" }, false);
vim.highlight.create('BufferTabpageFill', { guifg = "None" }, false);
vim.highlight.create('VertSplit', { guibg = "#16161e", guifg = "#16161e" }, false);
vim.highlight.create('TelescopeNormal', { guibg = "None", guifg = "None" }, false);
vim.highlight.create('TelescopeBorder', { guibg = "None", guifg = "None" }, false);
vim.highlight.link('TelescopeMatching', 'Constant', true);
vim.highlight.link('GitSignsCurrentLineBlame', 'Comment', true);
vim.highlight.create('StatusLine', { guibg = "None" }, false);
vim.highlight.create('StatusLineNC', { guibg = "None" }, false);

EOF


let mapleader = " "
lua << EOF
-- LSP keymap
local keymap = vim.api.nvim_set_keymap;

opts = { noremap=true, silent=true }

keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "L", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
keymap("n", "g]", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded' }})<CR>", opts)
keymap("n", "g[", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded' }})<CR>", opts)

-- git diff
keymap("n", "gtg", "<cmd>diffget //2<CR>", opts)
keymap("n", "gmg", "<cmd>diffget //3<CR>", opts)
keymap("n", "gu", "<cmd>diffupdate<CR>", opts)

-- Buffer Traversal
keymap("n", "gn", "<cmd>bn<CR>", opts)
keymap("n", "gp", "<cmd>bp<CR>", opts)

-- NERDTree
keymap("n", "<leader>t", ":NERDTreeToggle<CR>", opts)
keymap("n", "<leader>n", ":NERDTreeFind<CR>", opts)


-- file copy line
keymap("n", "<leader>cfp", ':let @" = expand("%")<CR>', opts)

-- paste line below. This sucks. Fix it.
keymap("n", "<leader>pl", "o<esc>p", opts)

-- Telescope
EOF


nnoremap <leader>ps <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR> 
nnoremap <C-p> :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fw :lua require('telescope.builtin').grep_string()<CR>
nnoremap <leader>lg :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>gh :G<CR>

" Snippets
imap <expr> <C-r>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-r>'
smap <expr> <C-r>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-r>'
" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.depreciatedSupport = true


on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  require("nvim-lsp-ts-utils").setup {
    debug = false,
    disable_command = false,
    enable_import_on_completion = true,
    import_all_timeout = 5000, --ms

    -- (ben): eslint config should go down here btw


    -- formatting
    enable_formatting = false,
    formatter = 'prettier_d_slim',
    formatter_config_fallback = nil,
  }


  require("nvim-lsp-ts-utils").setup_client(client)
end

local lspconfig = require('lspconfig')
lspconfig.tsserver.setup{
  capabilities = capabilites,
  on_attach = on_attach,
}




-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})
-- note you can (and should) specify configuration for specific filetypes. Like gitcommit.

-- lsp signature 
cfg = {}
require('lsp_signature').setup(cfg)


-- Diagnostic config
vim.diagnostic.config({
  float = {
    format = function(diagnostic)
      if not diagnostic.source or not diagnostic.user_data.lsp.code then
        return string.format('%s', diagnostic.message)
      end

      if diagnostic.source == 'eslint' then
        return string.format('%s [%s]', diagnostic.message, diagnostic.user_data.lsp.code)
      end

      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end
  },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = true,
})
EOF

