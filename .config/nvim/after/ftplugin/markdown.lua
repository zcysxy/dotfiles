vim.wo.foldtext = 'v:lua.vim.treesitter.foldtext()'
vim.cmd([[
    " set foldmethod=expr
    " set foldexpr=nvim_treesitter#foldexpr()
    au BufRead * silent! :set foldexpr=nvim_treesitter#foldexpr()
    " au BufRead * silent! :set foldtext=nvim_treesitter#foldtext()

    call matchadd('Conceal', '^\#* ', 10, -1)
    syntax match checkbox '^[\+\*\-] \[.\] '
    hi checkbox guifg=red ctermfg=red


    function! MarkdownFold()
      let line = getline(v:lnum)

      " Regular headers
      let depth = match(line, '\(^#\+\)\@<=\( .*$\)\@=')
      if depth > 0
        return ">" . depth
      endif

      " Setext style headings
      let nextline = getline(v:lnum + 1)
      if (line =~ '^.\+$') && (nextline =~ '^=\+$')
        return ">1"
      endif

      if (line =~ '^.\+$') && (nextline =~ '^-\+$')
        return ">2"
      endif

      " Front matter
      if v:lnum == 1 && line == '---'
        let b:markdown_frontmatter = 1
        return ">1"
      endif

      " End of front matter
      if (line == '...') && b:markdown_frontmatter
        unlet b:markdown_frontmatter
        return '<1'
      endif

      return "="
    endfunction

    if has("folding") && exists("g:markdown_folding")
      setlocal foldexpr=MarkdownFold()
      setlocal foldmethod=expr
      let b:undo_ftplugin .= " foldexpr< foldmethod<"
    endif

    function! GetSpaces(foldLevel)
        if &expandtab == 1
            " Indenting with spaces
            let str = repeat(" ", a:foldLevel / (&shiftwidth + 1) - 1)
            return str
        elseif &expandtab == 0
            " Indenting with tabs
            return repeat(" ", indent(v:foldstart) - (indent(v:foldstart) / &shiftwidth))
        endif
    endfunction

    function! MyFoldText()
        let startLineText = getline(v:foldstart)
        let endLineText = trim(getline(v:foldend))
        let indentation = GetSpaces(foldlevel("."))
        let spaces = repeat(" ", 200)

        let str = indentation . startLineText . "..." . spaces " . endLineText . spaces

        return str
    endfunction

    " Custom display for text when folding
    set foldtext=MyFoldText()
]])

vim.g.vim_markdown_fenced_languages = {'shell=sh', 'bash=sh'}
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.keymap.set({ 'n' },'<leader>ll', function() require("knap").toggle_autopreviewing() end)

vim.wo.conceallevel = 1
vim.o.conceallevel = 1
