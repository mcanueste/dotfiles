local from_root = function(func_name, opts)
  opts = opts or {}

  -- active_lsp_clients = vim.lsp.get_active_clients()
  -- if #active_lsp_clients ~= 0 then
  --   opts.cwd = active_lsp_clients.config.root_dir
  -- end

  if vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] then
    opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  end

  local func = require('telescope.builtin')[func_name]
  func(opts)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    event = "VeryLazy",
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    keys = {
      {
        "<leader><space>",
        "<cmd>Telescope resume<cr>",
        desc = "Resume last find/search"
      },
      {
        "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Current Buffer Fuzzy"
      },
      -- find
      { "<leader>ff", function() from_root("find_files") end, desc = "Files" },
      { "<leader>fp", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
      { "<leader>fg", function() from_root("live_grep") end, desc = "Grep" },
      { "<leader>fG", function() from_root("grep_string") end, desc = "Grep String" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>fc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
      { "<leader>fq", "<cmd>Telescope quickfix<cr>", desc = "Quickfix" },
      { "<leader>fQ", "<cmd>Telescope quickfixhistory<cr>", desc = "Quickfix History" },
      { "<leader>fs", "<cmd>Telescope spell_suggests<cr>", desc = "Spell Suggestions" },
      -- search
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sf", "<cmd>Telescope filetypes<cr>", desc = "Filetypes" },
      -- git
      { "<leader>gfc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gfC", "<cmd>Telescope git_bcommits<CR>", desc = "Buffer Commits" },
      { "<leader>gfs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      { "<leader>gfS", "<cmd>Telescope git_stash<CR>", desc = "Stash" },
      { "<leader>gfb", "<cmd>Telescope git_branches<CR>", desc = "Branches" },
      -- lsp
      { "<leader>fll", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>flr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
      { "<leader>fli", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
      { "<leader>fld", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions" },
      { "<leader>flt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
      { "<leader>fls", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
      { "<leader>flw", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace Symbols" },
      { "<leader>flW", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Dynamic Workspace Symbols" },
      { "<leader>flc", "<cmd>Telescope lsp_incoming_calls<CR>", desc = "Incoming Calls" },
      { "<leader>flC", "<cmd>Telescope lsp_outgoing_calls<CR>", desc = "Outgoing Calls" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            -- ["<c-t>"] = function(...)
            --   return require("trouble.providers.telescope").open_with_trouble(...)
            -- end,
            ["<a-n>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<a-p>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {'rg', '--files', '--hidden', '-g', '!.git'},
        },
        buffers = {
          show_all_buffers = true
        },
        git_status = {
          git_icons = {
            added = " ",
            changed = " ",
            copied = " ",
            deleted = " ",
            renamed = "➡",
            unmerged = " ",
            untracked = " ",
          },
        }
      }
    },
  },
}
