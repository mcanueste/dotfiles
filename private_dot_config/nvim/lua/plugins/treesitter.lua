return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        auto_install = true,
        indent = { enable = true, disable = { "python" } },
        highlight = {
          enable = true,
          use_languagetree = true,
          additional_vim_regex_highlighting = false,           -- { "markdown" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<nop>",
            node_decremental = "<bs>",
          },
        },
      }
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false       -- disable folds by default
    end
  },
  { "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" },
}
