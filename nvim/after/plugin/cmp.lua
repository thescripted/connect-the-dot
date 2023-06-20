local cmp = require('cmp')

cmp.setup({
	snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
	window = {
	  completion = cmp.config.window.bordered(),
	  documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
	  ['<C-Space>'] = cmp.mapping.complete(),
	  ['<CR>'] = cmp.mapping.confirm({ select = false }),
	  -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	  -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
	  -- ['<C-e>'] = cmp.mapping.abort(),
	}),
	sources = cmp.config.sources({
	  { name = 'nvim_lsp' },
	  { name = 'vsnip' }, -- For vsnip users.
	  -- { name = 'luasnip' }, -- For luasnip users.
	  -- { name = 'ultisnips' }, -- For ultisnips users.
	  -- { name = 'snippy' }, -- For snippy users.
	}, {
	  { name = 'buffer' },
	})
})
