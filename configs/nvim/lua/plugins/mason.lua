return {
  "williamboman/mason.nvim",
  keys = {
    { "<leader>cm", false },
    { "<leader>om", "<cmd>Mason<cr>", desc = "Mason" },
  },
  opts = {
    ensure_installed = {
      -- lsp
      "ansible-language-server",
      "bash-language-server",
      "docker-compose-language-service",
      "dockerfile-language-server",
      "gopls",
      "json-lsp",
      "lua-language-server",
      "pyright",
      "rnix-lsp",
      "rust-analyzer",
      "sqls",
      "taplo",
      "terraform-ls",
      "typescript-language-server",
      "yaml-language-server",

      -- format
      "shellharden",
      "shfmt",
      "yamlfmt",
      "sql-formatter",
      "stylua",
      "rustfmt",
      "black",
      "isort",

      -- lint
      "yamllint",
      "ansible-lint",
      "luacheck",
      "pydocstyle",
      "flake8",
      "pyproject-flake8",
      "pylint",
      "mypy",

      -- code action

      -- lint / codeaction
      "shellcheck",
      "cspell",
    },
  },
}
