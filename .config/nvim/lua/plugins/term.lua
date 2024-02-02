---@diagnostic disable: undefined-global
return {
	'akinsho/toggleterm.nvim',
	version = "*",
	config = function()
		require("toggleterm").setup({
			-- size can be a number or function which is passed the current terminal
			size = function(term)
				if term.direction == "horizontal" then
					return vim.o.lines * 0.4
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<c-\>]],
			hide_numbers = true,  -- hide the number column in toggleterm buffers
			autochdir = false,    -- when neovim changes it current directory the terminal will change it's own when next it's opened
			shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
			start_in_insert = true,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
			persist_size = true,
			persist_mode = true,  -- if set to true (default) the previous terminal mode will be remembered
			direction = 'horizontal',
			close_on_exit = true, -- close the terminal window when the process exits
			-- Change the default shell. Can be a string or a function returning a string
			shell = vim.o.shell,
			auto_scroll = true, -- automatically scroll to the bottom on terminal output
			-- This field is only relevant if direction is set to 'float'
			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = 'rounded', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
				-- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
				-- width = <value>,
				-- height = <value>,
				-- row = <value>,
				-- col = <value>,
				-- winblend = 3,
				-- zindex = <value>,
				title_pos = 'left' -- | 'center' | 'right', position of the title of the floating window
			},
			winbar = {
				enabled = false,
				name_formatter = function(term) --  term: Terminal
					return term.name
				end
			},
		})
	end
}
