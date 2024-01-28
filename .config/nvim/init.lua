require("config.lazy")

-- require("nvim-treesitter.install").prefer_git = true -- Use this in emergency

-- Remove the following lines if using LazyVim/LazyVim
require 'config.options'
require 'config.autocmds'
require 'config.keymap'
require 'plugins'
require 'utils'

vim.cmd([[
" NERDTree
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <M-l> :NERDTreeToggle<CR>
" nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

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

" Add optional packages.

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
]])

