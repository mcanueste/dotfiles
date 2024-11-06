return {
  'folke/trouble.nvim',
  opts = {},
  cmd = 'Trouble',
  keys = {
    {
      '[q',
      function()
        local tr = package.loaded.trouble
        if tr.is_open() then
          tr.prev { skip_groups = true, jump = true }
        else
          vim.cmd.cprev()
        end
      end,
      desc = 'Trouble Prev',
    },

    {
      ']q',
      function()
        local tr = package.loaded.trouble
        if tr.is_open() then
          tr.next { skip_groups = true, jump = true }
        else
          vim.cmd.cnext()
        end
      end,
      desc = 'Trouble Next',
    },

    {
      '<leader>ld',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics',
    },

    {
      '<leader>lwd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Workspace Diagnostics',
    },

    {
      '<leader>lq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List',
    },

    {
      '<leader>ll',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List',
    },

    {
      '<leader>ls',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols',
    },

    {
      '<leader>lg',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ...',
    },
  },
}
