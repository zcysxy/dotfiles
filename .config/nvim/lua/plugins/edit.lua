return {
	{
		'numToStr/Comment.nvim',
		lazy = false,
		config = function()
			require('Comment').setup()
		end
	},
	{
		'ggandor/leap.nvim',
		config = function()
			require('leap').add_default_mappings()
		end
	},
	'https://github.com/tpope/vim-surround',
	'https://github.com/jiangmiao/auto-pairs',
	{ 'mg979/vim-visual-multi', branch = 'master' },
	'tpope/vim-abolish'
	,
}
