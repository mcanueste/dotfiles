return {
  "rcarriga/nvim-notify",
  keys = {
    { "<leader>un", false },
    {
      "<leader>und",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Delete all Notifications",
    },
  },
}
