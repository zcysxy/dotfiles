--- @diagnostic disable: undefined-global
return {
	'fannheyward/telescope-coc.nvim',
	'catgoose/telescope-helpgrep.nvim',
	'nvim-telescope/telescope-ui-select.nvim',
	"nvim-telescope/telescope-live-grep-args.nvim",
	{
		"Shougo/deoplete.nvim",
		config = function()
			vim.g['deoplete#enable_at_startup'] = 1
			vim.g['deoplete#omni_patterns'] = {}
			vim.g['deoplete#omni_patterns.pandoc'] = '@\\w*'
		end
	},
	{ 'junegunn/fzf', build = ":call fzf#install()" },
	'junegunn/fzf.vim',
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require('telescope').setup {
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				extensions = {
					coc = {},
					helpgrep = {}
				},
			}

			require('telescope').load_extension('coc')
			require('telescope').load_extension('helpgrep')
			require('telescope').load_extension('ui-select')
			require('telescope').load_extension("live_grep_args")

			local map = vim.keymap.set
			vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { silent = true, noremap = true })
			vim.g.mapleader = " "
			vim.g.maplocalleader = " "

			map('n', '<leader>t', function()
				require('telescope.builtin').builtin { include_extensions = true }
			end)
			map('n', '<C-p>', ':Telescope commands<CR>', { silent = true })
			map('n', '<leader>o', ':Telescope find_files<CR>')
			-- map('n', '<leader>o', ':Telescope smart_open<CR>', { silent = true })
			map('n', '<leader>b', ':Telescope buffers<CR>', { silent = true })
			-- nnoremap <Leader>r :Rg<CR>
			map('n', '<leader>r', ':Telescope live_grep<CR>', { silent = true })
			map('n', '<leader>s', ':Telescope live_grep_args<CR>', { silent = true })
			-- nnoremap <A-p> :Commands<CR>
		end
	},
	{
		'prochri/telescope-all-recent.nvim',
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"kkharji/sqlite.lua",
		},
		opts =
		{
			-- your config goes here
		}
	}
}
