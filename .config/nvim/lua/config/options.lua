---@diagnostic disable: undefined-global

-- colors
vim.o.termguicolors = true
vim.g.syntax = "enable"
vim.o.winblend = 0

-- search
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- gutter
vim.o.number = true
vim.o.relativenumber = true

-- indent
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true
-- vim.o.smarttab = true
-- vim.o.autoindent = true
vim.cmd('filetype plugin indent on')

-- vim.o.conceallevel = 2
vim.o.timeoutlen = 500

-- Split
vim.o.splitbelow = 1
vim.o.splitright = 1
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

vim.cmd('syntax on')
vim.o.mouse = 'a'
vim.o.statusline = vim.o.statusline .. '%F'
vim.o.grepprg = "rg --vimgrep --no-heading --smart-case -g '!*~'"

vim.g.python3_host_prog = '/Users/ce/opt/anaconda3/bin/python'

-- Terminal
vim.env.ZDOTDIR = "/Users/ce/.zsh/simp"
vim.api.nvim_set_keymap('n', '<Leader>T', ':sp term://zsh<CR>i', {noremap = true})

-- Fuzzy Find
vim.o.path = vim.o.path .. "**"
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"

-- Fold
vim.o.foldlevel = 99
-- Use treesitter for folding
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

vim.g['pandoc#filetypes#pandoc_markdown'] = 0

-- Backup
if vim.fn.has("vms") then
  vim.o.nobackup = true         -- do not keep a backup file, use versions instead
else
  vim.o.backup = true           -- keep a backup file (restore to previous version)
  if vim.fn.has('persistent_undo') then
    vim.o.undofile = true       -- keep an undo file (undo changes after closing)
  end
end
vim.o.backupdir = os.getenv("HOME") .. "/.vimtmp//"
vim.o.directory = os.getenv("HOME") .. "/.vimtmp//"
vim.o.nowritebackup = true
vim.o.nobackup = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"


if tonumber(vim.o.t_Co) > 2 or vim.fn.has("gui_running") then
  -- Switch on highlighting the last used search pattern.
  vim.o.hlsearch = true
end

-- clipboard
vim.opt.clipboard = ""

-- default position
vim.opt.scrolloff = 8 -- scroll page when cursor is 8 lines from top/bottom
vim.opt.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right

-- ex line
vim.o.ls = 0
vim.o.ch = 0

-- misc
-- vim.opt.guicursor = ""
vim.opt.isfname:append("@-@")
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- wrapping
vim.opt.wrap = true
vim.opt.linebreak = true

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 0

-- local rc
vim.o.exrc = true
