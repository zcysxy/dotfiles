vim.cmd([[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()

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
]])

vim.g.vim_markdown_fenced_languages = {'shell=sh', 'bash=sh'}

