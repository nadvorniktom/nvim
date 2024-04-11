return {
  'tpope/vim-abolish', -- Better substitutions with 'S' instead of 's'
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { -- autocomplete braces, brackets and tags
    'm4xshen/autoclose.nvim',
    opts = {},
    config = function()
      require('autoclose').setup()
    end,
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup()
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup()

      -- disable cursor information because line numbers are already enabled
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return ''
      end

      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    config = function()
      local trouble = require 'trouble'
      vim.keymap.set('n', '<leader>xx', function()
        trouble.toggle()
      end)
      vim.keymap.set('n', '<leader>xw', function()
        trouble.toggle 'workspace_diagnostics'
      end)
      vim.keymap.set('n', '<leader>xd', function()
        trouble.toggle 'document_diagnostics'
      end)
      vim.keymap.set('n', '<leader>xq', function()
        trouble.toggle 'quickfix'
      end)
      vim.keymap.set('n', '<leader>xl', function()
        trouble.toggle 'loclist'
      end)
      vim.keymap.set('n', 'gR', function()
        trouble.toggle 'lsp_references'
      end)
    end,
  },
}
