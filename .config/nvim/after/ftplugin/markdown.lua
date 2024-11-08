---@diagnostic disable: undefined-global

vim.opt_local.shiftwidth = 4
vim.wo.foldtext = 'v:lua.vim.treesitter.foldtext()'
-- vim.cmd([[
--     " set foldmethod=expr
--     " set foldexpr=nvim_treesitter#foldexpr()
--     au BufRead * silent! :set foldexpr=nvim_treesitter#foldexpr()
--     " au BufRead * silent! :set foldtext=nvim_treesitter#foldtext()
--
--     call matchadd('Conceal', '^\#* ', 10, -1)
--     syntax match checkbox '^[\+\*\-] \[.\] '
--     hi checkbox guifg=red ctermfg=red
--
--
--     function! MarkdownFold()
--       let line = getline(v:lnum)
--
--       " Regular headers
--       let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
--       if depth > 0
--         return ">" . depth
--       endif
--
--       " Setext style headings
--       let nextline = getline(v:lnum + 1)
--       if (line =~ '^.\+$') && (nextline =~ '^=\+$')
--         return ">1"
--       endif
--
--       if (line =~ '^.\+$') && (nextline =~ '^-\+$')
--         return ">2"
--       endif
--
--       " Front matter
--       if v:lnum == 1 && line == '---'
--         let b:markdown_frontmatter = 1
--         return ">1"
--       endif
--
--       " End of front matter
--       if (line == '...') && b:markdown_frontmatter
--         unlet b:markdown_frontmatter
--         return '<1'
--       endif
--
--       return "="
--     endfunction
--
--     if has("folding") && exists("g:markdown_folding")
--       setlocal foldexpr=MarkdownFold()
--       setlocal foldmethod=expr
--       let b:undo_ftplugin .= " foldexpr< foldmethod<"
--     endif
--
--     function! GetSpaces(foldLevel)
--         if &expandtab == 1
--             " Indenting with spaces
--             let str = repeat(" ", a:foldLevel / (&shiftwidth + 1) - 1)
--             return str
--         elseif &expandtab == 0
--             " Indenting with tabs
--             return repeat(" ", indent(v:foldstart) - (indent(v:foldstart) / &shiftwidth))
--         endif
--     endfunction
--
--     function! MyFoldText()
--         let startLineText = getline(v:foldstart)
--         let endLineText = trim(getline(v:foldend))
--         let indentation = GetSpaces(foldlevel("."))
--         let spaces = repeat(" ", 200)
--
--         let str = indentation . startLineText . "..." . spaces " . endLineText . spaces
--
--         return str
--     endfunction
--
--     " Custom display for text when folding
--     set foldtext=MyFoldText()
-- ]])

vim.g.vim_markdown_fenced_languages = { 'shell=sh', 'bash=sh', 'r' }
-- vim.o.foldmethod = 'expr'
-- -- vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.keymap.set({ 'n' }, '<leader>ll', function() require("knap").toggle_autopreviewing() end)

vim.wo.conceallevel = 2
vim.o.conceallevel = 2

-- vim.cmd([[
-- vnoremap <silent> ic :<C-U>call MdCodeBlockTextObj('i')<CR>
-- onoremap <silent> ic :<C-U>call MdCodeBlockTextObj('i')<CR>
--
-- vnoremap <silent> ac :<C-U>call MdCodeBlockTextObj('a')<CR>
-- onoremap <silent> ac :<C-U>call MdCodeBlockTextObj('a')<CR>
-- ]])

vim.cmd([[
call vimtex#options#init()
call vimtex#text_obj#init_buffer()

omap <silent><buffer> i$ <plug>(vimtex-i$)
omap <silent><buffer> a$ <plug>(vimtex-a$)
xmap <silent><buffer> i$ <plug>(vimtex-i$)
xmap <silent><buffer> a$ <plug>(vimtex-a$)
omap <silent><buffer> id <plug>(vimtex-id)
omap <silent><buffer> ad <plug>(vimtex-ad)
xmap <silent><buffer> id <plug>(vimtex-id)
xmap <silent><buffer> ad <plug>(vimtex-ad)
]])

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Fold YAML frontmatter',
  pattern = '*.md',
  group = vim.api.nvim_create_augroup('markdown header', { clear = true }),
  callback = function()
    local current_buffer_id = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(current_buffer_id, 0, -1, true)

    for i, line in ipairs(lines) do
			if i == 1 and string.sub(line, 1, 3) ~= '---' then
				return
			end
      if i ~= 1 and string.sub(line, 1, 3) == '---' then
				local command = [[norm! ggV]] .. i-1 .. [[jzfj``]]
				vim.cmd(command)
				return
      end
    end
  end,
})
