vim.cmd([[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()

    call matchadd('Conceal', '^\#* ', 10, -1)
    syntax match checkbox '^[\+\*\-] \[.\] '
    hi checkbox guifg=red ctermfg=red
]])

