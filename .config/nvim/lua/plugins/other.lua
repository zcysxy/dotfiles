---@diagnostic disable: undefined-global

return {
	-- Plugins
	-- Meta
	'mrquantumcodes/retrospect.nvim',

	-- Shell and Terminal
	'eandrju/cellular-automaton.nvim',
	'nvim-lua/plenary.nvim',

	-- UI
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function() require('ibl').setup() end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			"neovim/nvim-lspconfig",
			"luukvbaal/statuscol.nvim",
		},
		config = function()
			require('ufo').setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { 'treesitter', 'indent' }
				end
			})
		end
	},
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require "statuscol.builtin"
			require("statuscol").setup {
				-- relculright = true,
				-- segments = {
				--   { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
				--   { text = { "%s" },                  click = "v:lua.ScSa" },
				--   { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				-- },
			}
		end,
	},

	-- HTML
	'AndrewRadev/tagalong.vim',

	{
		'stevearc/oil.nvim',
		config = function()
			require('oil').setup()
		end
	},
}
