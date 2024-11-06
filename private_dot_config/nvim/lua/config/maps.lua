-- Clear search with ESC
vim.keymap.set({ 'n', 'i' }, '<esc>', '<cmd>noh<cr><esc>', { noremap = true, desc = 'Clear search' })

-- Paste without saving the selected text to register
vim.keymap.set('v', '<leader>ep', [["_dP]], { noremap = true, desc = 'Paste w/o register' })

-- Cut word under cursor without saving to register
vim.keymap.set('n', '<leader>ed', [[viw"_d]], { noremap = true, desc = 'Delete word w/o register' })

-- Cut selected text without saving to register
vim.keymap.set('v', '<leader>ed', [["_d]], { noremap = true, desc = 'Delete w/o register' })

-- Move to the beginning or end of line with H and L
vim.keymap.set({ 'n', 'v' }, 'H', '^', { noremap = true, desc = 'Move beginning of line' })
vim.keymap.set('n', 'L', '$', { noremap = true, desc = 'Move end of line' })
vim.keymap.set('v', 'L', 'g_', { noremap = true, desc = 'Move end of line' })

-- Center cursor after jumps
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, desc = 'Center cursor after jump' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, desc = 'Center cursor after jump' })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, desc = 'Center cursor after jump' })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, desc = 'Center cursor after jump' })

-- add missing conceallevel toggle
vim.keymap.set({ 'n' }, '<leader>tu', function()
  local winnr = vim.api.nvim_get_current_win()
  local conceallevel = vim.api.nvim_win_get_option(winnr, 'conceallevel')
  local newconceallevel = math.fmod(conceallevel + 1, 4)
  vim.opt.conceallevel = newconceallevel
end, { noremap = true, desc = "Toggle 'conceallevel'" })
