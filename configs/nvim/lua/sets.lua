-- [[ Setting options ]]
-- See `:help vim.o`

-- Enable mouse mode
vim.o.mouse = 'a'

-- Fat cursor in insert mode
vim.o.guicursor = ""

-- Line numbers
vim.o.nu = true
vim.o.relativenumber = true

-- Tabstops and indentation (Using vim-sleuth instead)
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

-- No swap but long undotree
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.cache/vim/undodir"
vim.o.undofile = true

-- Set highlight on search
-- vim.o.hlsearch = false
vim.o.incsearch = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 50
vim.wo.signcolumn = 'yes'
vim.opt.isfname:append("@-@")

-- Draw line on column 80
vim.o.colorcolumn = "80"

-- Keep 8 lines on the bottom of the screen
vim.o.scrolloff = 8

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

