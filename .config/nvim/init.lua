local vim = vim

-- Pre
vim.g['pandoc#filetypes#pandoc_markdown'] = 0

-- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { silent = true, noremap = true })
--vim.cmd [[let maplocalleader="<space>"]]
vim.g.maplocalleader = " "
vim.g.mapleader = " "
require('lazy').setup('lazies')

require 'plugins'
require 'keymap'
require 'autocmds'
require 'utils'

-- Appearance
vim.cmd([[
    augroup user_colors
      autocmd!
      autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NormalSB ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight TelescopeNormal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight TelescopeBorder ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight Conceal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NvimTreeNormal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NvimTreeCursorLine ctermbg=NONE guibg=NONE
    augroup END
]])

vim.opt.termguicolors = true
require('bluloco').setup({ transparent = true, italics = true })
-- Set different colorscheme for different backgrounds
-- require('dark_notify').run()
vim.schedule(function()
  if vim.o.background == 'dark' then
    vim.cmd([[colorscheme gruvbox-material]])
  else
    vim.cmd([[colorscheme bluloco]])
  end
end
)

vim.api.nvim_set_hl(0, "TelescopeNormal", { ctermbg = "darkblue", bg = "NONE" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { ctermbg = "darkblue", bg = "NONE" })
vim.cmd('highlight Visual term=reverse cterm=reverse guibg=Grey')
-- vim.api.nvim_set_hl(0, "Visual", { term = "reverse", cterm = "reverse", guibg = "Grey" })

-- Enable folds
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  command = "normal zx",
})
vim.o.foldlevel = 99
-- Use treesitter for folding
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- General
-- vim.o.conceallevel = 2
vim.o.timeoutlen = 500

vim.o.splitbelow = 1
vim.o.splitright = 1

vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
vim.o.number = true
vim.o.mouse = 'a'
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.o.backupdir = '~/.vimtmp//,.'
vim.o.directory = '~/.vimtmp//,.'
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smarttab = true
vim.o.hlsearch = true
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

-- PREVIOUS INIT.VIM
vim.cmd([[
" MAPPINGS
inoremap jk <ESC>" quick escape
" inoremap kj <ESC>
nmap j gj
nmap k gk
nmap H ^
nmap L $
"nmap J <C-D>
"nmap K <C-U>
" nmap <ENTER> o<ESC>k " new line
nmap <S-CR> i<CR><ESC>0 " break line
" Execute code
nnoremap <C-CR> :r!./%<CR>
nnoremap <BS> ddkk " delete line
" inoremap <TAB> <C-n>
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>
" map <leader>d :bdelete<cr>
map <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>

" Move lines up/down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" NERDTree
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <M-l> :NERDTreeToggle<CR>
" nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

" " Comment
nmap <C-_> gcc
vmap <C-_> gc

" GitGutter
set updatetime=200
let g:gitgutter_async=0
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight SignColumn ctermbg=NONE
highlight GitGutterAdd ctermfg=2 ctermbg=NONE guibg=NONE
highlight GitGutterChange ctermfg=3 ctermbg=NONE guibg=NONE
highlight GitGutterDelete ctermfg=1 ctermbg=NONE guibg=NONE
highlight GitGutterChangeDelete ctermfg=4 ctermbg=NONE guibg=NONE

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif
set nowritebackup
set nobackup

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
]])

vim.cmd([[set exrc secure]])

