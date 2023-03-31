function! BlockFolds()
 let thisline = getline(v:lnum)
 if match(thisline, '# %%') >= 0
    return ">1"
 else
    return "="
 endif
endfunction

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldexpr=BlockFolds()
set nofoldenable                     " Disable folding at startup.
