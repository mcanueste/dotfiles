local function git_root()
  local root = string.gsub(vim.fn.system 'git rev-parse --show-toplevel', '\n', '')
  if vim.v.shell_error == 0 then
    return root
  end
  return nil
end

local function run_cmd(func, cwd)
  local builtin = require 'telescope.builtin'
  local utils = require 'telescope.utils'
  if cwd then
    builtin[func] { cwd = utils.buffer_dir() }
  else
    builtin[func] { cwd = git_root() }
  end
end

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'danielfalk/smart-open.nvim', branch = '0.2.x', dependencies = { 'kkharji/sqlite.lua' } },
    },
    init = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = {
            '.git/.*',
            'node_modules/.*',
            'env/.*',
            '.venv/.*',
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          },
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }
      pcall(require('telescope').load_extension 'fzf')
      pcall(require('telescope').load_extension 'smart_open')
      pcall(require('telescope').load_extension 'ui-select')
    end,
    keys = {
      { '<leader><leader>', '<cmd>Telescope resume<cr>', desc = 'Telescope Resume' },

      -- Find Keymaps
      {
        '<leader>ff',
        function()
          run_cmd('find_files', false)
        end,
        desc = 'Find Files',
      },
      {
        '<leader>fF',
        function()
          run_cmd('find_files', true)
        end,
        desc = 'Find Files (CWD)',
      },

      {
        '<leader>fg',
        function()
          run_cmd('live_grep', false)
        end,
        desc = 'Grep Files',
      },
      {
        '<leader>fG',
        function()
          run_cmd('live_grep', true)
        end,
        desc = 'Grep Files (CWD)',
      },

      {
        '<leader>fh',
        function()
          run_cmd('grep_string', false)
        end,
        desc = 'Grep Current Word',
      },
      {
        '<leader>fH',
        function()
          run_cmd('grep_string', true)
        end,
        desc = 'Grep Current Word (CWD)',
      },

      { '<leader>fo', '<cmd>Telescope oldfiles<cr>', desc = 'Recent Files' },
      { '<leader>fr', '<cmd>Telescope registers<cr>', desc = 'Registers' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Buffers' },
      { '<leader>fm', '<cmd>Telescope marks<cr>', desc = 'Marks' },
      { '<leader>fc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>fs', '<cmd>Telescope smart_open<cr>', desc = 'Smart Open' },

      -- Search Keymaps
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
      { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Autocommands' },
      { '<leader>sc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
      { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
      { '<leader>sf', '<cmd>Telescope filetypes<cr>', desc = 'Filetypes' },
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
      { '<leader>sH', '<cmd>Telescope highlights<cr>', desc = 'Highlight Groups' },
      { '<leader>sm', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
    },
  },
}
