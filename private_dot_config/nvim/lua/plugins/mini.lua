return {
  {
    'echasnovski/mini.basics',
    version = '*',
    init = function()
      require("mini.basics").setup({
        options = {
          -- Extra UI features ('winblend', 'cmdheight=0', ...)
          extra_ui = true,

          -- Presets for window borders ('single', 'double', ...)
          win_borders = "bold",
        },

        -- Mappings. Set to `false` to disable.
        mappings = {
          -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
          -- Supply empty string to not create these mappings.
          option_toggle_prefix = "<leader>t",

          -- Window navigation with <C-hjkl>, resize with <C-arrow>
          windows = true,
        },
      })
      -- delete mini.basics binding for sys clipboard yank and paste (using global clipboard)
      vim.keymap.del({ "n", "x" }, "gy")
      vim.keymap.del({ "n", "x" }, "gp")
    end
  },

  {
    'echasnovski/mini.bracketed',
    version = '*',
    opts = {
      buffer = { suffix = "b" },
      comment = { suffix = "c" },
      conflict = { suffix = "x" },
      diagnostic = { suffix = "d" },
      jump = { suffix = "j" },
      indent = { suffix = "" },           -- using indentscope instead
      location = { suffix = "" },         -- using trouble instead
      quickfix = { suffix = "" },         -- using trouble instead
      file = { suffix = "" },             -- not using
      oldfile = { suffix = "" },          -- not using
      treesitter = { suffix = "" },       -- not using
      undo = { suffix = "" },             -- not using
      window = { suffix = "" },           -- not using
      yank = { suffix = "" },             -- not using
    }
  },

  { 'echasnovski/mini.bufremove', version = '*', opts = {} },
  { 'echasnovski/mini.ai',        version = '*', opts = {}, },   -- TODO: define custom text objects for frequent use cases
  { 'echasnovski/mini.move',      version = '*', opts = {} },
  { 'echasnovski/mini.splitjoin', version = '*', opts = { mappings = { toggle = "<leader>es" } } },
  { 'echasnovski/mini.surround',  version = '*', opts = {} },
  { 'echasnovski/mini.comment',   version = '*', opts = {} },

  {
    'echasnovski/mini.trailspace',
    version = '*',
    lazy = true,
    opts = {},
    keys = {
      {
        "<leader>et",
        function()
          ts = require('mini.trailspace')
          ts.trim()
          ts.trim_last_lines()
        end,
        desc = "Trim",
      },
    },
  },

  {
    'echasnovski/mini.hipatterns',
    version = '*',
    event = "VeryLazy",
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },

  { 'echasnovski/mini.indentscope', version = '*', event = "VeryLazy", opts = { symbol = "│" } },
}
