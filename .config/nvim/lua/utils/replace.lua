vim.cmd([[
" Remove qf entries
function! s:QfRemoveAtCursor() abort
  let currline = line('.')
  let items = getqflist()->filter({ index -> (index + 1) != currline })
  call setqflist(items, 'r')
  execute 'normal ' . currline . 'G'
endfunction

augroup quickfix
  autocmd!
  autocmd FileType qf nnoremap <buffer><silent> dd :call <SID>QfRemoveAtCursor()<CR>
augroup END

" Auto open qf after grep
function! s:Grep(...) abort
  let pattern = get(a:, 1, '')
  if pattern == '' | return | endif

  let path = get(a:, 2, '.')
  execute 'silent! grep! "' . escape(pattern, '"-') . '" ' . path . ' | redraw! | copen'
endfunction

command! -nargs=+ -complete=file Grep silent! call s:Grep(<f-args>)

" Replace
if !exists('s:latest_greps')
  let s:latest_greps = {}
endif

function! s:Grep(...) abort
  let pattern = get(a:, 1, '')
  if pattern == '' | return | endif

  let s:latest_greps[pattern] = 1
  let path = get(a:, 2, '.')
  execute 'silent! grep! "' . escape(pattern, '"-') . '" ' . path . ' | redraw! | copen'
endfunction

function! s:Replace(original, ...) abort
  " if a:original == '' || a:replacement == '' | return | endif
  if a:original == '' | return | endif
  if a:0 > 0
    let replacement = a:1
  else
    let replacement = ''
  end

  execute 'cfdo %s/' . escape(a:original, '/') . '/' . replacement . '/ge'
endfunction

function! LatestGreps(ArgLead, CmdLine, CursorPos)
  return keys(s:latest_greps)
endfunction

command! -nargs=+ -complete=file Grep silent! call s:Grep(<f-args>)
command! -nargs=+ -complete=customlist,LatestGreps Replace silent! call s:Replace(<f-args>)
]])
