vim.g.maplocalleader = " "
vim.cmd [[
    let g:jupytext_fmt = 'py'
    let g:python3_host_prog = '/opt/homebrew/anaconda3/envs/py3/bin/python'
    let g:jupyter_highlight_cells = 1
    let g:jupyter_cell_separators = ['# %%']

    " Run current file
    nnoremap <buffer> <silent> <localleader>jr :JupyterRunFile<CR>
    " nnoremap <buffer> <silent> <localleader>I :PythonImportThisFile<CR>

    " Change to directory of current file
    nnoremap <buffer> <silent> <localleader>jcd :JupyterCd %:p:h<CR>

    " Send a selection of lines
    nnoremap <buffer> <silent> <localleader>jj :JupyterSendCell<CR>
    xnoremap <buffer> <silent> <localleader>j :JupyterSendRange<CR>
    " nmap     <buffer> <silent> <localleader>e <Plug>JupyterRunTextObj
    " vmap     <buffer> <silent> <localleader>e <Plug>JupyterRunVisual

    " Debugging maps
    " nnoremap <buffer> <silent> <localleader>b :PythonSetBreak<CR>
]]
