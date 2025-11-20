---@diagnostic disable: undefined-global

return {
	{
		'goerz/jupytext.nvim',
		opts = {
			format = 'py',
		}
	},
	-- {
	-- 	'dccsillag/magma-nvim',
	-- 	config = function()
	-- 		vim.g.maplocalleader = " "
	-- 		vim.g.magma_automatically_open_output = false
	-- 		local map = vim.api.nvim_set_keymap
	-- 		local opts = { noremap = true, silent = true }
	-- 		map("n", "<localleader>rr", ":MagmaEvaluateLine<CR>", opts)
	-- 		map("x", "<localleader>r", ":<C-u>MagmaEvaluateVisual<CR>", opts)
	-- 		map("n", "<localleader>ro", ":MagmaShowOutput<CR>", opts)
	-- 		map("n", "<localleader>rc", ":MagmaReevaluateCell<CR>", opts)
	-- 		map("n", "<localleader>r", ":MagmaEvaluateOperator<CR>", opts)
	-- 	end
	-- },
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 50

			-- keymaps
			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",
				{ silent = true, desc = "Initialize the plugin" })
			vim.keymap.set("n", "<localleader>mo", ":MoltenEvaluateOperator<CR>",
				{ silent = true, desc = "run operator selection" })
			vim.keymap.set("n", "<localleader>mm", ":MoltenEvaluateLine<CR>",
				{ silent = true, desc = "evaluate line" })
			vim.keymap.set("n", "<localleader>mc", ":MoltenReevaluateCell<CR>",
				{ silent = true, desc = "re-evaluate cell" })
			vim.keymap.set("v", "<localleader>m", ":<C-u>MoltenEvaluateVisual<CR>gv",
				{ silent = true, desc = "evaluate visual selection" })
			vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>",
				{ silent = true, desc = "hide output" })
			vim.keymap.set("n", "<localleader>me", ":noautocmd MoltenEnterOutput<CR>",
				{ silent = true, desc = "show/enter output" })
		end,
	},
	{
		'jupyter-vim/jupyter-vim',
		config = function()
			vim.g.maplocalleader = " "
			vim.g.jupytext_enable = 1
			vim.g.jupytext_command = 'jupytext'
			vim.g.jupytext_fmt = 'py:percent'
			vim.g.python3_host_prog = '/opt/homebrew/anaconda3/bin/python'
			vim.g.jupyter_highlight_cells = 1
			vim.g.jupyter_cell_separators = { '# %%' }

			local map = function(mode, key, cmd)
				vim.api.nvim_buf_set_keymap(0, mode, key, cmd, { noremap = true, silent = true })
			end

			--  Run current file
			-- map('n', '<localleader>I', ':PythonImportThisFile<CR>')
			map('n', '<localleader>jr', ':JupyterRunFile<CR>')

			-- Change to directory of current file
			map('n', '<localleader>jcd', ':JupyterCd %:p:h<CR>')

			-- Send a selection of lines
			map('n', '<localleader>jj', ':JupyterSendCell<CR>')
			map('x', '<localleader>j', ':JupyterSendRange<CR>')
			-- map('n', '<localleader>e', '<Plug>JupyterRunTextObj')
			-- map('v', '<localleader>e', '<Plug>JupyterRunVisual')

			-- Debugging maps
			-- map('n', '<localleader>b', ':PythonSetBreak<CR>')
		end
	}
}
