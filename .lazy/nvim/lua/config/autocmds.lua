-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.cmd([[
    augroup user_colors
      autocmd!
      autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NormalNC ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight NormalSB ctermbg=NONE guibg=NONE
      autocmd ColorScheme * highlight TelescopeNormal ctermbg=NONE guibg=NONE
    augroup END
]])
