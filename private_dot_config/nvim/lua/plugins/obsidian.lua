local date_verbose = function()
  return os.date '%A, %B %d, %Y'
end

local daily = function()
  return os.date 'logs/%Y/%m/%Y-%m-%d'
end

local daily_previous = function()
  return os.date('logs/%Y/%m/%Y-%m-%d', os.time() - 24 * 60 * 60)
end

local daily_next = function()
  return os.date('logs/%Y/%m/%Y-%m-%d', os.time() + 24 * 60 * 60)
end

local weekly = function()
  -- Week starts from Monday
  return os.date('logs/%Y/Weekly/%yW%V', os.time() - 24 * 60 * 60)
end

return {
  'epwalsh/obsidian.nvim',
  version = '*', -- latest release
  lazy = true,
  ft = 'markdown',
  dependencies = { 'nvim-lua/plenary.nvim' },
  init = function()
    local home = vim.fn.expand '$HOME'
    local vault_path = home .. '/notes'
    local obsidian = require 'obsidian'
    obsidian.setup {
      dir = vault_path,
      log_level = vim.log.levels.INFO,
      open_notes_in = 'vsplit',
      new_notes_location = 'current_dir',
      ui = { enable = true },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },

      templates = {
        subdir = '_templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {
          date_verbose = date_verbose,
          daily = daily,
          daily_previous = daily_previous,
          daily_next = daily_next,
          weekly = weekly,
        },
      },

      attachments = { img_folder = '_attachments' },

      daily_notes = {
        folder = 'logs',
        date_format = '%Y/%m/%Y-%m-%d',
        template = 'daily.md',
      },

      note_id_func = function(title)
        -- If title is not given, use ISO timestamp, otherwise use as is
        if title == nil then
          return tostring(os.date '%y%m%d%H%M%S')
        end
        return title
      end,

      disable_frontmatter = true,
      note_frontmatter_func = function(note)
        local out = { date = os.date '%Y-%m-%d', lastmod = os.date '%Y-%m-%d' }
        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end
        return out
      end,

      -- overwrite_mappings = true,
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gf'] = {
          action = function()
            return obsidian.util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true, desc = 'Follow link' },
        },
        -- Toggle check-boxes.
        ['<leader>nc'] = {
          action = function()
            return obsidian.util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = 'Toggle Checkbox' },
        },
      },
    }

    vim.keymap.set('n', '<leader>nO', '<cmd>ObsidianOpen<cr>', { noremap = true, desc = 'Open' })
    vim.keymap.set('n', '<leader>nn', '<cmd>ObsidianNew<cr>', { noremap = true, desc = 'New Note' })
    vim.keymap.set('n', '<leader>nN', '<cmd>ObsidianNewFromTemplate<cr>', { noremap = true, desc = 'New Note (T)' })
    vim.keymap.set('n', '<leader>nf', '<cmd>ObsidianQuickSwitch<cr>', { noremap = true, desc = 'Find' })
    vim.keymap.set('n', '<leader>ng', '<cmd>ObsidianSearch<cr>', { noremap = true, desc = 'Grep or Create' })
    vim.keymap.set('n', '<leader>nG', '<cmd>ObsidianTags<cr>', { noremap = true, desc = 'Tag Search' })
    vim.keymap.set('n', '<leader>nt', '<cmd>ObsidianToday<cr>', { noremap = true, desc = 'Today' })
    vim.keymap.set('n', '<leader>ny', '<cmd>ObsidianYesterday<cr>', { noremap = true, desc = 'Yesterday' })
    vim.keymap.set('n', '<leader>nm', '<cmd>ObsidianTemplate<cr>', { noremap = true, desc = 'Template' })
    vim.keymap.set('n', '<leader>nv', '<cmd>ObsidianFollowLink vsplit<cr>', { noremap = true, desc = 'Follow Vertical' })
    vim.keymap.set('n', '<leader>ns', '<cmd>ObsidianFollowLink hsplit<cr>', { noremap = true, desc = 'Follow Horizontal' })
    vim.keymap.set('n', '<leader>nl', '<cmd>ObsidianLinks<cr>', { noremap = true, desc = 'Links' })
    vim.keymap.set('n', '<leader>nb', '<cmd>ObsidianBacklinks<cr>', { noremap = true, desc = 'Backlinks' })
    vim.keymap.set('n', '<leader>nT', '<cmd>ObsidianTOC<cr>', { noremap = true, desc = 'TOC' })
    vim.keymap.set('v', '<leader>nl', '<cmd>ObsidianLink<cr>', { noremap = true, desc = 'Link to File' })
    vim.keymap.set('v', '<leader>nL', '<cmd>ObsidianLinkNew<cr>', { noremap = true, desc = 'Link to New File' })
    vim.keymap.set('v', '<leader>ne', '<cmd>ObsidianExtractNote<cr>', { noremap = true, desc = 'Extract Note' })
    vim.keymap.set('n', '<leader>ni', '<cmd>ObsidianPasteImg<cr>', { noremap = true, desc = 'Paste Image' })
    vim.keymap.set('n', '<leader>nr', '<cmd>ObsidianRename --dry-run<cr>', { noremap = true, desc = 'Rename (dry-run)' })
    vim.keymap.set('n', '<leader>nR', '<cmd>ObsidianRename<cr>', { noremap = true, desc = 'Rename' })

    -- update `lastmod` on edited files
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.md',
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        for line_num = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
          local line = vim.api.nvim_buf_get_lines(bufnr, line_num, line_num + 1, false)[1]

          if line:match 'lastmod:' then
            local new_date = os.date 'lastmod: %Y-%m-%d'
            vim.api.nvim_buf_set_lines(bufnr, line_num, line_num + 1, false, { tostring(new_date) })
            break
          end
        end
      end,
    })
  end,
}
