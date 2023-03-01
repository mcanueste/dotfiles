vim.opt.undofile    = true  -- Enable persistent undo (see also `:h undodir`)

vim.opt.backup      = false -- Don't store backup while overwriting the file
vim.opt.writebackup = false -- Don't store backup while overwriting the file

vim.opt.mouse       = 'a'   -- Enable mouse for all available modes

vim.opt.updatetime = 50     -- Fast update time

vim.opt.isfname:append("@-@")        -- Filename for gf and other file commands
vim.cmd('filetype plugin indent on') -- Enable all filetype plugins

-- Appearance
vim.opt.breakindent   = true    -- Indent wrapped lines to match line start
vim.opt.cursorline    = true    -- Highlight current line
vim.opt.linebreak     = true    -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.opt.number        = true    -- Show line numbers
vim.opt.rnu           = true    -- Use relative numbers
vim.opt.splitbelow    = true    -- Horizontal splits will be below
vim.opt.splitright    = true    -- Vertical splits will be to the right
vim.opt.termguicolors = true    -- Enable gui colors
vim.opt.scrolloff     = 8       -- Min lines to keep above and below the cursor

vim.opt.ruler         = false   -- Don't show cursor position in command line
vim.opt.colorcolumn   = "80"    -- Color column 80
vim.opt.showmode      = false   -- Don't show mode in command line
vim.opt.wrap          = false   -- Display long lines as just one line

vim.opt.signcolumn    = 'yes'   -- Always show sign column (otherwise it will shift text)
vim.opt.fillchars     = 'eob: ' -- Don't show `~` outside of buffer

-- Editing
vim.opt.ignorecase  = true -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.incsearch   = true -- Show search results while typing
vim.opt.infercase   = true -- Infer letter cases for a richer built-in keyword completion
vim.opt.smartcase   = true -- Don't ignore case when searching if pattern has upper case
vim.opt.smartindent = true -- Make indenting smart

vim.opt.completeopt   = 'menuone,noinsert,noselect' -- Customize completions
vim.opt.virtualedit   = 'block'                     -- Allow going past the end of line in visual block mode
vim.opt.formatoptions = 'qjl1'                      -- Don't autoformat comments

if vim.fn.has('nvim-0.9') == 1 then
  vim.opt.shortmess:append('WcC') -- Reduce command line messages
  vim.o.splitkeep = 'screen'      -- Reduce scroll during window split
else
  vim.opt.shortmess:append('Wc')  -- Reduce command line messages
end

vim.opt.pumblend  = 10 -- Make builtin completion menus slightly transparent
vim.opt.pumheight = 10 -- Make popup menu smaller
vim.opt.winblend  = 10 -- Make floating windows slightly transparent

vim.opt.listchars = 'extends:…,precedes:…,nbsp:␣' -- Define which helper symbols to show
vim.opt.list      = true                          -- Show some helper symbols

-- Enable syntax highlighing if it wasn't already (as it is time consuming)
if vim.fn.exists("syntax_on") ~= 1 then vim.cmd([[syntax enable]]) end

-- Use some common window borders presets
local win_borders_fillchars = {
  bold    = { vert = 'vert:┃', rest = ',horiz:━,horizdown:┳,horizup:┻,verthoriz:╋,vertleft:┫,vertright:┣' },
  dot     = { vert = 'vert:·', rest = ',horiz:·,horizdown:·,horizup:·,verthoriz:·,vertleft:·,vertright:·' },
  double  = { vert = 'vert:║', rest = ',horiz:═,horizdown:╦,horizup:╩,verthoriz:╬,vertleft:╣,vertright:╠' },
  single  = { vert = 'vert:│', rest = ',horiz:─,horizdown:┬,horizup:┴,verthoriz:┼,vertleft:┤,vertright:├' },
  solid   = { vert = 'vert: ', rest = ',horiz: ,horizdown: ,horizup: ,verthoriz: ,vertleft: ,vertright: ' },
}
local fillchars = win_borders_fillchars["bold"]
local chars = fillchars.vert .. (vim.fn.has('nvim-0.7') == 1 and fillchars.rest or '')
vim.opt.fillchars:append(chars)
