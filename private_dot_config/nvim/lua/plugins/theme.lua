return {
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'mocha',
      dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.15,
      },
      default_integrations = true,
      integrations = {
        gitsigns = true,
        harpoon = true,
        markdown = true,
        mini = {
          enabled = true,
          indentscope_color = 'blue',
        },
        cmp = true,
        dap = true,
        dap_ui = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        treesitter = true,
        treesitter_context = true,
        telescope = { enabled = true },
        lsp_trouble = true,
        which_key = true,
      },
    },
    config = function()
      vim.cmd [[colorscheme catppuccin-mocha]]
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup()
    end,
  },
  {
    'echasnovski/mini.icons',
    lazy = true,
    opts = {},
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
  },
  { 'stevearc/dressing.nvim', event = 'VeryLazy' },
}
