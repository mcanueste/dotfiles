return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require('which-key')
    wk.setup()

    wk.add({
      { "<leader>a",  group = "ai" },
      { "<leader>b",  group = "buffer" },
      { "<leader>c",  group = "copilot" },
      { "<leader>d",  group = "dap" },
      { "<leader>dg", group = "go" },
      { "<leader>e",  group = "edit" },
      { "<leader>f",  group = "find" },
      { "<leader>g",  group = "git" },
      { "<leader>gt", group = "toggle" },
      { "<leader>h",  group = "harpoon" },
      { "<leader>l",  group = "lsp" },
      { "<leader>lw", group = "workspace" },
      { "<leader>n",  group = "notes" },
      { "<leader>o",  group = "open" },
      { "<leader>s",  group = "search" },
      { "<leader>t",  group = "toggle" },
      {
        mode = { "o", "o", "x", "x" },
        { "i ", desc = "Whitespace" },
        { "i?", desc = "User Prompt" },
        { "i_", desc = "Underscore" },
        { "ia", desc = "Argument" },
        { "ic", desc = "Class" },
        { "if", desc = "Function" },
        { "io", desc = "Block-Conditional-Loop" },
        { "iq", desc = "Quote" },
      },
    })
  end
}
