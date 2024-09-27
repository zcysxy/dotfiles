---@diagnostic disable: undefined-global

return {
	'sindrets/winshift.nvim',
	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		conifg = function()
			require("trouble").setup {
				icon = true,
			}
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
		config = function()
			require('lualine').setup({
				options = {
					disabled_filetypes = { 'alpha' }
				},
				sections = {
					lualine_c = { { 'filename', path = 1 } }
				}
			})
		end
	},
	"edkolev/tmuxline.vim",
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('todo-comments').setup({
				highlight = {
					pattern = [[.*<(KEYWORDS)\s*]],
				},
				search = {
					pattern = [[\b(KEYWORDS)\b]],
				},
			})
		end
	},
	"j-hui/fidget.nvim",
	-- " Plug 'https://github.com/vim-airline/vim-airline'
}
