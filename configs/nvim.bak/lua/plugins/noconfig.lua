return {
  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- tab/space/indent auto config
  { 'tpope/vim-sleuth', event = "VeryLazy", },

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    event = "VeryLazy",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  }
}
