---@diagnostic disable: undefined-global

return {
	'lervag/vimtex',
	lazy = false,
	config = function()
		vim.g.tex_flavor = 'latex'
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_view_method = 'sioyek'
		vim.g.vimtex_view_skim_sync = 1
		vim.g.vimtex_view_skim_activate = 0
		vim.g.vimtex_view_sioyek_sync = 1
		vim.g.vimtex_view_sioyek_activate = 0
		vim.g.vimtex_fold_enable = 1
		vim.cmd([[let g:vimtex_env_toggle_math_map = {
      \ '$': '\[',
      \ '\[': 'align',
      \}
			    let g:vimtex_indent_conditionals = {
          \ 'open': '\v%(\\newif)@<!\\if%(f>|false|field|name|numequal|thenelse|toggle)@!',
          \ 'else': '\\else\>',
          \ 'close': '\\fi\>',
          \}
					let g:vimtex_fold_types = {
						\ 'comments': {'enabled': 1},
					\}
			]])
	end,
	ft = { 'tex', 'latex', 'markdown' },
}
