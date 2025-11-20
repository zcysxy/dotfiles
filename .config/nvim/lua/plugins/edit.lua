return {
	{
		'numToStr/Comment.nvim',
		lazy = false,
		config = function()
			require('Comment').setup()
		end
	},
	{ 'ggandor/leap.nvim', },
	'https://github.com/tpope/vim-surround',
	'https://github.com/jiangmiao/auto-pairs',
	{ 'mg979/vim-visual-multi', branch = 'master' },
	'tpope/vim-abolish',

	-- spectre
	'nvim-pack/nvim-spectre',
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "UIEnter",
		opts = { keymaps = {useDefaults = true} },
	},
}
