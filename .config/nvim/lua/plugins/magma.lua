vim.g.maplocalleader = " "
vim.cmd([[
    let g:magma_automatically_open_output = v:false
    nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
    xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
    nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>
    nnoremap <silent>       <LocalLeader>rc :MagmaReevaluateCell<CR>
    nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
]])
