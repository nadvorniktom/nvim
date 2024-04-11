-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Insert empty line and stay in normal mode
vim.keymap.set('n', '<leader>o', 'o<Esc>')
vim.keymap.set('n', '<leader>O', 'O<Esc>')

-- dismiss notifications
vim.keymap.set('n', '<leader>h', ':NoiceDismiss<CR>', { silent = true })

-- git
vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { silent = true, noremap = true, desc = 'Lazy[G]it' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window resizing/navigation
vim.keymap.set('n', '=', [[<cmd>vertical resize +5<cr>]])
vim.keymap.set('n', '-', [[<cmd>vertical resize -5<cr>]])
vim.keymap.set('n', '+', [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set('n', '_', [[<cmd>horizontal resize -2<cr>]])
vim.keymap.set('n', '<C-Right>', '<C-w>l')
vim.keymap.set('n', '<C-Up>', '<C-w>k')
vim.keymap.set('n', '<C-Left>', '<C-w>h')
vim.keymap.set('n', '<C-Down>', '<C-w>j')

-- paste/delete and don't overwrite buffer with was overwritten
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- should be default
vim.keymap.set('i', '<C-c>', '<Esc>')

-- for some reason gets only triggered from here and not other files
vim.keymap.set('n', '<leader>db', vim.cmd.DBUIToggle)

-- spell check toggle
vim.keymap.set('n', '<leader>sc', ':set invspell<CR>', { silent = true })

-- See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- When using multiple windows make inactive window's background lighter(using tokyo-night theme)
vim.api.nvim_command 'highlight ActiveWindow guibg=#1a1b26'
vim.api.nvim_command 'highlight InactiveWindow guibg=#1e2030'
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    vim.opt_local.winhighlight = 'Normal:ActiveWindow,NormalNC:InactiveWindow'
  end,
})

-- c#
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cs', 'ps1' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- experimenting with lua
vim.keymap.set('n', '<leader>m', function()
  local path = vim.fn.getcwd()
  local files = Scandir(path)
  for _, file in ipairs(files) do
    print(file)
  end
end, { silent = true })

-- get all file names in current folder
function Scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. directory .. '"')
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end
  pfile:close()
  return t
end
