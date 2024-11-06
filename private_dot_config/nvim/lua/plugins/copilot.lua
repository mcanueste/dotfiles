return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = '<C-r>',
          open = '<C-CR>',
        },
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },

      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<C-l>',
          dismiss = '<C-h>',
          next = '<C-j>',
          prev = '<C-k>',
          accept_word = false,
          accept_line = false,
        },
      },

      filetypes = {
        yaml = true,
        markdown = true,
        help = false,
        gitcommit = true,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
    },
    keys = {
      {
        '<leader>cT',
        function()
          require('copilot.suggestion').toggle_auto_trigger()
        end,
        desc = 'Toggle Copilot Auto Trigger',
      },
    },
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    build = 'make tiktoken',
    opts = {
      debug = true,

      model = 'gpt-4', -- GPT model to use
      temperature = 0.1, -- GPT temperature

      context = 'buffers', -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
      history_path = vim.fn.stdpath 'data' .. '/copilotchat_history', -- Default path to stored history
      callback = nil, -- Callback to use when ask response is received
    },
    keys = {
      { '<leader>cc', ':CopilotChatToggle<cr>', desc = 'Toggle Chat' },
      { '<leader>cS', ':CopilotChatStop<cr>', desc = 'Stop Output' },
      { '<leader>cR', ':CopilotChatReset<cr>', desc = 'Reset Chat' },
      { '<leader>cM', ':CopilotChatModels<cr>', desc = 'Models' },

      { '<leader>ce', ':CopilotChatExplain<cr>', desc = 'Explain' },
      { '<leader>ce', ':CopilotChatReview<cr>', desc = 'Review' },
      { '<leader>cf', ':CopilotChatFix<cr>', desc = 'Fix' },
      { '<leader>co', ':CopilotChatOptimize<cr>', desc = 'Optimize' },
      { '<leader>cd', ':CopilotChatDocs<cr>', desc = 'Docs' },
      { '<leader>ct', ':CopilotChatTests<cr>', desc = 'Tests' },
      { '<leader>ci', ':CopilotChatFixDiagnostic<cr>', desc = 'Fix Diagnostic' },
      { '<leader>cm', ':CopilotChatCommit<cr>', desc = 'Commit Message' },
      { '<leader>cs', ':CopilotChatCommitStaged<cr>', desc = 'Commit Message (Staged)' },
    },
  },
}
