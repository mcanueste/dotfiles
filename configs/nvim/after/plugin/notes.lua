require("zk").setup({
  picker = "telescope",
  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },
    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

local opts = { noremap = true, silent = false }
local cmd_new = ":ZkNew { title = vim.fn.input('Title: ') }<CR>"
local cmd_open = ":ZkNotes { sort = { 'modified' } }<CR>"
local cmd_tags = ":ZkTags<CR>"
local cmd_query = ":ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>"
local cmd_match = ":'<,'>ZkMatch<CR>"
local cmd_journal = ":ZkNew { dir = 'journal' }<CR>"

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>zn", cmd_new, opts)

-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>zo", cmd_open, opts)

-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>zt", cmd_tags, opts)

-- Search for the notes matching a given query.
vim.api.nvim_set_keymap("n", "<leader>zf", cmd_query, opts)

-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<leader>zf", cmd_match, opts)

-- Open todays journal note
vim.api.nvim_set_keymap("n", "<leader>zj", cmd_journal, opts)

