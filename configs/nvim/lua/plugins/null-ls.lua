return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function()
    local nls = require("null-ls")
    return {
      sources = {
        -- Format
        nls.builtins.formatting.shellharden,
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.yamlfmt,
        nls.builtins.formatting.sql_formatter,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.rustfmt,
        nls.builtins.formatting.black,
        nls.builtins.formatting.isort,

        -- Diagnostics
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.diagnostics.ansiblelint,
        nls.builtins.diagnostics.yamllint,
        -- nls.builtins.diagnostics.cspell,
        -- nls.builtins.diagnostics.luacheck,
        nls.builtins.diagnostics.pydocstyle,
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.pyproject_flake8,
        nls.builtins.diagnostics.pylint,
        nls.builtins.diagnostics.mypy,

        -- Code action
        nls.builtins.code_actions.shellcheck,
        -- nls.builtins.code_actions.cspell,
      },
    }
  end,
}
