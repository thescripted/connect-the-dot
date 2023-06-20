local harpoon = require('harpoon')

harpoon.setup({
    global_settings = {
        save_on_toggle = true,
        save_on_change = true,
    },
})


vim.keymap.set('n', 'mf', require('harpoon.mark').add_file)
vim.keymap.set('n', 'mv', require('harpoon.ui').toggle_quick_menu)
vim.keymap.set('n', '<S-l>', require('harpoon.ui').nav_next)
vim.keymap.set('n', '<S-h>', require('harpoon.ui').nav_prev)

for i = 1, 9 do
    vim.keymap.set('n', string.format("m%d", i), function()
        require("harpoon.ui").nav_file(i)
    end)
end

