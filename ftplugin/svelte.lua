vim.keymap.set('n', '<F5>', ':split<CR> | :res 5 | :term<CR> | inpm run dev<CR><C-\\><C-n>G', { silent = true })
vim.keymap.set('n', '<F6>', ':split<CR> | :res 5 | :term<CR> | inpm run dev -- --open<CR><C-\\><C-n>G', { silent = true })
