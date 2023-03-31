require 'plugins'
require 'keymap'
require('lualine').setup({
    options = {
        disabled_filetypes = { 'alpha' }
    }
})

vim.cmd([[
    augroup user_colors
      autocmd!
      autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NormalSB ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight TelescopeNormal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight Conceal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NvimTreeNormal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NvimTreeCursorLine ctermbg=NONE guibg=NONE
    augroup END
]])

-- Enable folds
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    command = "normal zx",
})
vim.o.foldlevel = 99

vim.opt.termguicolors = true
require('bluloco').setup({ transparent = true, italics = true })
vim.cmd.colorscheme 'bluloco'

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--vim.cmd [[let maplocalleader="<space>"]]

vim.o.conceallevel = 2
vim.o.timeoutlen = 500

vim.o.splitbelow = 1
vim.o.splitright = 1

-- PREVIOUS INIT.VIM
vim.cmd([[
" Basic
syntax on
filetype plugin indent on
set number
set mouse=a
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backupdir=~/.vimtmp//,.
set directory=~/.vimtmp//,.
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set nofoldenable

set expandtab
set autoindent
set smarttab
highlight Visual term=reverse cterm=reverse guibg=Grey " ctermbg=NONE
set hlsearch

" MAPPINGS
inoremap jk <ESC>" quick escape
" inoremap kj <ESC>
nmap j gj
nmap k gk
nmap H ^
nmap L $
"nmap J <C-D>
"nmap K <C-U>
nmap <ENTER> o<ESC>k " new line
nmap <S-CR> i<CR><ESC>0 " break line
" Execute code
nnoremap <C-CR> :!./%<CR>
nnoremap <Leader><CR> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <BS> ddkk " delete line
" inoremap <TAB> <C-n>
map <leader>n :bnext<cr>
map <leader>p :bprevious<cr>
map <leader>d :bdelete<cr>

" Move lines up/down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Terminal
let $ZDOTDIR="/Users/ce/.zsh/simp"
nnoremap <Leader>T :sp term://zsh<CR>i

" Fuzzy Find
set path+=**
set wildmenu
set wildmode=longest:full,full

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()

" Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/preservim/nerdcommenter'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }
Plug 'jupyter-vim/jupyter-vim'

call plug#end()

" NERDTree
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <M-b> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

" Comment
nmap <C-_> <LEADER>c<SPACE>
vmap <C-_> <LEADER>c<SPACE>

" nnoremap <C-p> :Telescope command_palette<CR>
nnoremap <C-p> :Telescope commands<CR>
nnoremap <Leader>o :Telescope find_files<CR>
" nnoremap <A-p> :Commands<CR>

" GitGutter
set updatetime=200
let g:gitgutter_async=0
let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight SignColumn ctermbg=NONE
highlight GitGutterAdd ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1
highlight GitGutterChangeDelete ctermfg=4

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

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
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
]])

