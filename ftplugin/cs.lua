vim.keymap.set('n', '<F4>', ':split<CR> | :res 16 | :term<CR> | idotnet build<CR><C-\\><C-n>G', { silent = true })
vim.keymap.set('n', '<F5>', ':split<CR> | :res 5 | :term<CR> | idotnet run<CR><C-\\><C-n>G', { silent = true })
vim.keymap.set('n', '<F6>', ':split<CR> | :res 5 | :term<CR> | idotnet watch<CR><C-\\><C-n>G', { silent = true })
