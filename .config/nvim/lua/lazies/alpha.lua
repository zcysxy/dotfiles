---@diagnostic disable: undefined-global

return {
	'goolord/alpha-nvim',
	config = function()
		require 'alpha'.setup(require 'alpha.themes.dashboard'.config)

		local alpha = require('alpha')
		local dashboard = require('alpha.themes.dashboard')
		local ver_table = vim.version()
		local ver = 'NVIM v' .. ver_table.major .. '.' .. ver_table.minor .. '.' .. ver_table.patch

		dashboard.section.header.val = ver --{
		--       --"                                                    ",
		--       --" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
		--       --" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
		--       --" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
		--       --" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		--       --" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		--       --" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
		--       --"                                                    ",
		-- --}
		dashboard.section.buttons.val = {
			--dashboard.button( "e", "  New" , ":ene <BAR> startinsert <CR>"),
			--dashboard.button( "f", "  Find" , ":Telescope find_files<CR>"),
			--dashboard.button( "r", "  Recent" , ":Telescope find_files<CR>"),
			--dashboard.button( "w", "  Search" , ":Rg<CR>"),
			--dashboard.button( "q", "  Quit" , ":qa<CR>"),
			dashboard.button("e", "New", ":ene <BAR> startinsert <CR>"),
			--dashboard.button( "t", "Tree" , ":ene | NvimTreeFocus | only<CR>"),
			dashboard.button("t", "Tree", ":ene | NERDTree | only<CR>"),
			dashboard.button("f", "Oil", ":Oil<CR>"),
			dashboard.button("o", "Files", ":Telescope find_files<CR>"),
			dashboard.button("r", "Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("s", "Search", ":Telescope live_grep<CR>"),
			dashboard.button("q", "Quit", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end
}
