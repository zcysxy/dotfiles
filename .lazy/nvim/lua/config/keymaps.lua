-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.cmd([[
inoremap jk <ESC>" quick escape
inoremap kj <ESC>
nmap j gj
nmap k gk
nmap H ^
nmap L $
"nmap J <C-D>
"nmap K <C-U>
nmap <ENTER> o<ESC>k " new line
nmap <S-CR> i<CR><ESC>0 " break line
" Execute code
nmap <C-CR> :!./%<CR>
nmap <BS> ddkk " delete line
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
]])
