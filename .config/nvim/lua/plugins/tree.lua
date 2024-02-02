---@diagnostic disable: undefined-global

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	},
	-- {
	-- 	'nvim-tree/nvim-tree.lua',
	-- 	config = function()
	-- 		require("nvim-tree").setup {
	-- 		}
	--
	-- 		-- Startup from a dir
	-- 		local function open_nvim_tree(data)
	-- 			-- buffer is a directory
	-- 			local directory = vim.fn.isdirectory(data.file) == 1
	--
	-- 			if not directory then
	-- 				return
	-- 			end
	--
	-- 			-- change to the directory
	-- 			vim.cmd.cd(data.file)
	--
	-- 			-- open the tree
	-- 			require("nvim-tree.api").tree.open()
	-- 		end
	-- 		vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
	--
	-- 		vim.g.loaded_netrw = 1
	-- 		vim.g.loaded_netrwPlugin = 1
	--
	-- 		vim.cmd [[autocmd FileType NvimTree nnoremap <buffer> ? g?]]
	-- 	end
	-- }
}
