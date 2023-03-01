return {
  'echasnovski/mini.trailspace',
  event = "VeryLazy",
  keys = {
    {
      "<leader>tw",
      function() require("mini.trailspace").trim() end,
      desc = "Trim whitespaces"
    },
    {
      "<leader>tl",
      function() require("mini.trailspace").trim_last_lines() end,
      desc = "Trim eof empty lines"
    },
  },
  config = function()
    require("mini.trailspace").setup()
  end,
}
