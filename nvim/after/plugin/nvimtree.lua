-- configure nvim-tree
require("nvim-tree").setup({
    -- change folder arrow icons
    renderer = {
        icons = {
            glyphs = {
                folder = {
                    arrow_closed = "", -- arrow when folder is closed
                    arrow_open = "", -- arrow when folder is open
                },
            },
        },
    },
    -- disable window_picker for
    -- explorer to work well with
    -- window splits
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
    -- 	git = {
    -- 		ignore = false,
    -- 	},
    view = {
        adaptive_size = true
    }
})

vim.keymap.set("n", "<leader>n", vim.cmd.NvimTreeFindFile)
vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)
