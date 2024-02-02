---@diagnostic disable: undefined-global
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

return {
	{
		"jpalardy/vim-slime",
		init = function()
			vim.g.slime_no_mappings = 1
			vim.g.slime_target = "neovim"

			map("n", "<leader>sc", "<Plug>SlimeSendCell", opts)
			map("x", "<leader>s", "<Plug>SlimeRegionSend", opts)
			map("n", "<leader>ss", "<Plug>SlimeLineSend", opts)
		end
	},
	{
		'klafyvel/vim-slime-cells',
		dependencies = { { 'jpalardy/vim-slime', opt = true } },
		config = function()
			map("n", "<leader>sn", "<Plug>SlimeCellsSendAndGoToNext", opts)
			map("n", "<leader>s]", "<Plug>SlimeCellsNext", opts)
			map("n", "<leader>s[", "<Plug>SlimeCellsPrev", opts)
			vim.g.slime_cell_delimiter = "#%%"
		end
	}
}
