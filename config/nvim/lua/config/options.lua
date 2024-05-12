-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Do not save when switching buffers
-- o.hidden = true

-- sensible defaults from https://www.youtube.com/watch?v=J9yqSdvAKXY
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true -- save the file before leaving if changed
vim.opt.autoread = true  -- auto load file changes occured outside vim
-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true -- round indent to sw compatible
vim.opt.expandtab = true

-- Decrease update time
vim.opt.timeoutlen = 500
-- vim.opt.updatetime = 200
vim.opt.updatetime = 50 -- primeagen value

-- Number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 8

-- Better editor UI
vim.opt.number = true
-- vim.opt.numberwidth = 3
vim.opt.relativenumber = false
-- vim.opt.signcolumn = 'yes:2'
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = false
-- vim.opt.colorcolumn = '80,120'

-- Better editing experience
vim.opt.expandtab = true
-- o.smarttab = true
vim.opt.cindent = true
-- o.autoindent = true
vim.opt.wrap = false -- using wrapping-paper to show it in virtual text.
vim.opt.textwidth = 300
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1 -- If negative, shiftwidth value is used
vim.opt.list = false
vim.opt.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂,eol:⁋'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
vim.opt.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- vim.opt.hlsearch = true
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "clear search highlight on ESC" })

-- Undo and backup options
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.directory = vim.fn.stdpath('data') .. 'tmp'
vim.opt.undodir = vim.fn.stdpath('data') .. 'undo'

-- Remember 1000 items in commandline history
vim.opt.history = 1000

-- Better buffer splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preserve view while jumping
-- o.jumpoptions = 'view'

-- WIP Global Statusline + slick separator
vim.opt.laststatus = 3
vim.api.nvim_set_hl(0, 'WinSeparator', { bg = 'None' })

-- vim.highlight.create('WinSeparator', { guibg = none }, false)
vim.g['netrw_banner'] = 0
vim.g['netrw_liststyle'] = 3
vim.g['netrw_winsize'] = 25

if vim.g.neovide then
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  -- vim.g.neovide_transparency = 0.9
  -- vim.g.transparency = 0.8
  -- vim.g.neovide_background_color = "#ffffff" .. alpha()
  vim.g.neovide_scroll_animation_length = 0.05
end

vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "[q]uit vim" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "[Q]uit vim w/o saving" })
