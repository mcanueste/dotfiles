return {
  'robitx/gp.nvim',
  config = function()
    local home = vim.fn.expand '$HOME'
    local keypath = home .. '/.ssh/openai.key'
    local gpdefaults = require 'gp.defaults'

    require('gp').setup {
      openai_api_key = { 'cat', keypath },
      image = { secret = { 'cat', keypath } },
      providers = {
        openai = {
          disable = false,
          endpoint = 'https://api.openai.com/v1/chat/completions',
        },
      },
      agents = {
        {
          name = 'ChatGPT4',
          provider = 'openai',
          chat = true,
          command = false,
          model = { model = 'gpt-4', temperature = 0.1, top_p = 1 }, -- TODO: what temp to set?
          system_prompt = gpdefaults.chat_system_prompt,
        },
        {
          name = 'CodeGPT4',
          provider = 'openai',
          chat = false,
          command = true,
          model = { model = 'gpt-4', temperature = 0.1, top_p = 1 }, -- TODO: what temp to set?
          system_prompt = gpdefaults.code_system_prompt,
        },
      },

      chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-a><C-a>' },
      chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-a>d' },
      chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-a>s' },
      chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-a>c' },
    }
  end,
  keys = {
    { '<leader>aa', '<cmd>GpChatToggle vsplit<cr>', desc = 'Toggle Chat' },
    { '<leader>an', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat' },
    { '<leader>af', '<cmd>GpChatFinder<cr>', desc = 'Find Chats' },
    { '<leader>ap', '<cmd>GpChatPaste vsplit<cr>', desc = 'Paste to Chat' },
    { '<leader>ar', '<cmd>GpChatRespond<cr>', desc = 'Request Response' },
    { '<leader>ad', '<cmd>GpChatDelete<cr>', desc = 'Delete Chat' },
    { '<leader>as', '<cmd>GpStop<cr>', desc = 'Stop Chat' },
    { '<leader>ai', '<cmd>GpImplement<cr>', desc = 'Implement Selected Comment' },
    { '<leader>ac', '<cmd>GpContext vsplit<cr>', desc = 'Custom Context' },
  },
}
