return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        -- sh/bash
        -- nls.builtins.formatting.shfmt,
        nls.builtins.formatting.beautysh,
        nls.builtins.formatting.shellharden,
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.code_actions.shellcheck,

        -- sql
        -- nls.builtins.formatting.sql_formatter,

        -- yaml
        nls.builtins.formatting.yamlfmt,
        nls.builtins.diagnostics.yamllint,

        -- docker
        -- nls.builtins.diagnostics.hadolint, -- TODO

        -- ansible
        nls.builtins.diagnostics.ansiblelint,

        -- lua
        -- nls.builtins.formatting.stylua,
        -- nls.builtins.diagnostics.luacheck,

        -- go
        nls.builtins.formatting.gofumpt,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.golines,
        nls.builtins.diagnostics.golangci_lint,

        -- rust
        -- nls.builtins.formatting.rustfmt,

        -- python
        nls.builtins.formatting.ruff,
        nls.builtins.diagnostics.mypy,

        -- spelling
        -- nls.builtins.diagnostics.cspell,
        -- nls.builtins.code_actions.cspell,
      },
    }
  end,
}
