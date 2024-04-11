return {
  'kristijanhusak/vim-dadbod-ui',
  config = function()
    local function db_completion()
      require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
    end

    vim.g.db_ui_save_location = vim.fn.stdpath 'config' .. require('plenary.path').path.sep .. 'db_ui'

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'sql' },
      command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'dbout' },
      callback = function()
        -- vim.opt_local.omnifunc = 'vim_dadbod_completion#omni'
        vim.opt_local.fileencodings = 'cp1250'
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'dbui' },
      callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'sql',
        'mysql',
        'plsql',
      },
      callback = function()
        vim.schedule(db_completion)
      end,
    })
  end,
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
