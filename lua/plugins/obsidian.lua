return {
  'epwalsh/obsidian.nvim',
  version = '*', -- latest
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'godlygeek/tabular',
    'preservim/vim-markdown',
    'preservim/vim-pencil',
  },
  config = function()
    require('obsidian').setup {
      workspaces = {
        {
          name = 'secondbrain',
          path = '~/obsidian/secondbrain',
        },
      },
      log_level = vim.log.levels.INFO,
      completion = {
        nvim_cmp = true,
        min_chars = 2,
        new_notes_location = 'current_dir',
        preferred_link_style = 'wiki',
        prepend_note_id = true,
        prepend_note_path = false,
        use_path_only = false,
      },
      mappings = {
        ['<leader>gd'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ['<leader>ch'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ''
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. '-' .. suffix
      end,
      note_frontmatter_func = function(note)
        local out = { id = note.id, aliases = note.aliases, tags = note.tags, area = '', project = '' }
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,
      templates = {
        subdir = 'templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        substitutions = {},
      },
      backlinks = {
        height = 10,
        wrap = true,
      },
      tags = {
        height = 10,
        wrap = true,
      },
      follow_url_func = function(url)
        vim.fn.jobstart { 'open', url } -- Mac OS
      end,
      use_advanced_uri = false,
      open_app_foreground = false,
      picker = {
        name = 'telescope.nvim',
        mappings = {
          new = '<C-x>',
          insert_link = '<C-l>',
        },
      },
      sort_by = 'modified',
      sort_reversed = true,
      open_notes_in = 'current',

      -- Optional, configure additional syntax highlighting / extmarks.
      -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
      ui = {
        enable = true, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        checkboxes = {
          [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
          ['x'] = { char = '', hl_group = 'ObsidianDone' },
          ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
          ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = '•', hl_group = 'ObsidianBullet' },
        external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = 'ObsidianRefText' },
        highlight_text = { hl_group = 'ObsidianHighlightText' },
        tags = { hl_group = 'ObsidianTag' },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = '#f78c6c' },
          ObsidianDone = { bold = true, fg = '#89ddff' },
          ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
          ObsidianTilde = { bold = true, fg = '#ff5370' },
          ObsidianBullet = { bold = true, fg = '#89ddff' },
          ObsidianRefText = { underline = true, fg = '#c792ea' },
          ObsidianExtLinkIcon = { fg = '#c792ea' },
          ObsidianTag = { italic = true, fg = '#89ddff' },
          ObsidianHighlightText = { bg = '#75662e' },
        },
      },
      attachments = {
        img_folder = 'assets/imgs',
        -- A function that determines the text to insert in the note when pasting an image.
        -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
        -- This is the default implementation.
        ---@param client obsidian.Client
        ---@param path Path the absolute path to the image file
        ---@return string
        img_text_func = function(client, path)
          local link_path
          local vault_relative_path = client:vault_relative_path(path)
          if vault_relative_path ~= nil then
            -- Use relative path if the image is saved in the vault dir.
            link_path = vault_relative_path
          else
            -- Otherwise use the absolute path.
            link_path = tostring(path)
          end
          local display_name = vim.fs.basename(link_path)
          return string.format('![%s](%s)', display_name, link_path)
        end,
      },
      yaml_parser = 'native',
    }
  end,
}
