-- bootstrap lazy.nvim, LazyVim and your plugins
vim.cmd([[
    augroup user_colors
      autocmd!
      autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NormalSB ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight TelescopeNormal ctermbg=NONE guibg=NONE
    augroup END
]])

require("config.lazy")
