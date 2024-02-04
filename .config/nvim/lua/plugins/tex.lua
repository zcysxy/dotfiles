---@diagnostic disable: undefined-global

return {
	'lervag/vimtex',
	config = function()
		vim.g.tex_flavor = 'latex'
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_view_method = 'skim'
		vim.g.vimtex_view_skim_sync = 1
		vim.g.vimtex_view_skim_activate = 1
		vim.g.vimtex_fold_enable = 1
	end,
	ft = { 'tex', 'latex', 'markdown' },
}
