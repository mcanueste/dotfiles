vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set("n", "J", "mzJ`z") -- Don't move cursor when moving lines
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Focus on cursor after <C-d>
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Focus on cursor after <C-u>
vim.keymap.set("n", "n", "nzzzv") -- Focus on cursor after n during search
vim.keymap.set("n", "N", "Nzzzv") -- Focus on cursor after N during search

-- handle line movement on wrapped lines
vim.keymap.set(
  { 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true }
)
vim.keymap.set(
  { 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true }
)

-- Paste without changing the register
vim.keymap.set("x", "<A-p>", [["_dP]])

-- Delete without saving to register
vim.keymap.set({"n", "v"}, "<A-d>", [["_d]])
vim.keymap.set({"n", "v"}, "<A-d><A-d>", [["_dd]])

-- Add empty lines before and after cursor line
vim.keymap.set(
  'n', 'gO', "<cmd>call append(line('.') - 1, repeat([''], v:count1))<cr>", 
  { desc = 'Put empty line above' }
)
vim.keymap.set(
  'n', 'go', "<cmd>call append(line('.'),     repeat([''], v:count1))<cr>", 
  { desc = 'Put empty line below' }
)

-- Copy/paste with system clipboard
vim.keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', 'gp', '"+p', { desc = 'Paste from system clipboard' })
-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
vim.keymap.set('x', 'gp', '"+P', { desc = 'Paste from system clipboard' })

-- Search & Replace word under cursor
-- vim.keymap.set(
--   "n", "gr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
--   { desc = "Search & Replace word under cursor"}
-- )

-- Reselect latest changed, put, or yanked text
vim.keymap.set(
  'n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', 
  { expr = true, desc = 'Visually select changed text' }
)

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
vim.keymap.set(
  'x', 'g/', '<esc>/\\%V', 
  { silent = false, desc = 'Search inside visual selection' }
)

-- Search visually selected text (slightly better than builtins in Neovim>=0.8)
vim.keymap.set('x', '*', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])
vim.keymap.set('x', '#', [[y?\V<C-R>=escape(@", '?\')<CR><CR>]])

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
vim.keymap.set(
  'n', '<C-S>', '<Cmd>silent! update | redraw<CR>', { desc = 'Save' }
)
vim.keymap.set(
  { 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', 
  { desc = 'Save and go to Normal mode' }
)

-- Correct latest misspelled word by taking first suggestion.
-- Use `<C-g>u` in Insert mode to mark this as separate undoable action.
-- Source: https://stackoverflow.com/a/16481737
-- NOTE: this remaps `<C-z>` in Normal mode (completely stops Neovim), but
-- it seems to be too harmful anyway.
vim.keymap.set(
  'n', '<C-Z>', '[s1z=', { desc = 'Correct latest misspelled word' }
)
vim.keymap.set(
  'i', '<C-Z>', '<C-g>u<Esc>[s1z=`]a<C-g>u', 
  { desc = 'Correct latest misspelled word' }
)

-- Move only sideways in command mode. Using `silent = false` makes movements
-- to be immediately shown.
vim.keymap.set('c', '<M-h>', '<Left>',  { silent = false, desc = 'Left' })
vim.keymap.set('c', '<M-l>', '<Right>', { silent = false, desc = 'Right' })

-- Don't `noremap` in insert mode to have these keybindings behave exactly
-- like arrows (crucial inside TelescopePrompt)
vim.keymap.set('i', '<M-h>', '<Left>',  { noremap = false, desc = 'Left' })
vim.keymap.set('i', '<M-j>', '<Down>',  { noremap = false, desc = 'Down' })
vim.keymap.set('i', '<M-k>', '<Up>',    { noremap = false, desc = 'Up' })
vim.keymap.set('i', '<M-l>', '<Right>', { noremap = false, desc = 'Right' })

vim.keymap.set('t', '<M-h>', '<Left>',  { desc = 'Left' })
vim.keymap.set('t', '<M-j>', '<Down>',  { desc = 'Down' })
vim.keymap.set('t', '<M-k>', '<Up>',    { desc = 'Up' })
vim.keymap.set('t', '<M-l>', '<Right>', { desc = 'Right' })

-- Make file executable
vim.keymap.set(
  "n", "<leader>x", "<cmd>!chmod +x %<CR>", 
  { silent = true, desc = "Make current file executable" }
)

-- Format file -- TODO add this binding to lsp config
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
