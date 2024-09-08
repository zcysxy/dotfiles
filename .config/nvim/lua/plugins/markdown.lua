---@diagnostic disable: undefined-global
return {
	--'godlygeek/tabular',
	{
		'preservim/vim-markdown',
		ft = { 'markdown' },
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_math = 1
			vim.g.vim_markdown_strikethrough = 1
			vim.g.vim_markdown_toc_autofit = 1
			vim.g["pandoc#syntax#conceal#use"] = 0
		end
	},
	{
		"frabjous/knap",
		ft = { "markdown" },
		config = function()
			local gknapsettings = {
				mdoutputext = "pdf",
				mdtopdf = "panrun %docroot%",
				mdtopdfviewerlaunch = "open -a Skim.app %outputfile%",
				mdtopdfviewerrefresh = "kill -HUP %pid%",
				-- mdtopdfbufferasstdin = true,
				delay = 1000
			}
			vim.g.knap_settings = gknapsettings

			-- F5 processes the document once, and refreshes the view
			-- kmap({ 'n', 'v', 'i' },'<F5>', function() require("knap").process_once() end)

			-- F6 closes the viewer application, and allows settings to be reset
			-- kmap({ 'n', 'v', 'i' },'<F6>', function() require("knap").close_viewer() end)

			-- F7 toggles the auto-processing on and off

			-- F8 invokes a SyncTeX forward search, or similar, where appropriate
			-- kmap({ 'n', 'v', 'i' },'<F8>', function() require("knap").forward_jump() end)
		end
	},
	-- {
	--   'vim-pandoc/vim-pandoc',
	--   config = function()
	--     vim.g['pandoc#biblio#bibs'] = { '/Users/ce/3-KNWL/33-Ref/myLibrary.bib' };
	--     vim.g['pandoc#modules#disabled'] = { 'keyboard' }
	-- 	vim.g['pandoc#filetypes#handled'] = { 'pandoc', 'markdown' }
	--     vim.g['pandoc#filetypes#pandoc_markdown'] = 0
	--   end
	-- },
	-- 'vim-pandoc/vim-pandoc-syntax',
	-- {
	-- 	'aspeddro/cmp-pandoc.nvim',
	-- 	dependencies = { 'nvim-lua/plenary.nvim' },
	-- 	config = function()
	-- 		require('cmp').setup {
	-- 			sources = {
	-- 				{ name = 'pandoc' },
	-- 			},
	-- 		}
	-- 		require('cmp_pandoc').setup()
	-- 	end
	-- }
	{
		'MeanderingProgrammer/markdown.nvim',
		name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('render-markdown').setup({
				latex = { enabled = false },
				win_options = { conceallevel = { rendered = 2 } },
				callout = {
					note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'DiagnosticInfo' },
					remark = { raw = '[!rmk]', rendered = '󰳦 Remark', highlight = 'DiagnosticError' },
					caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'DiagnosticError' },
					qn = { raw = '[!qn]', rendered = '󰘥 Question', highlight = 'DiagnosticWarn' },
					question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'DiagnosticWarn' },
					IMPORTANT = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'DiagnosticHint' },
					important = { raw = '[!impt]', rendered = '󰅾 Important', highlight = 'DiagnosticHint' },
					ex = { raw = '[!ex]', rendered = '󰉹 Example', highlight = 'DiagnosticHint' },
					example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'DiagnosticHint' },
					TIP = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'DiagnosticOk' },
					tip = { raw = '[!tip]', rendered = '󰌶 Tip', highlight = 'DiagnosticOk' },
					warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'DiagnosticWarn' },
					abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'DiagnosticInfo' },
					todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'DiagnosticInfo' },
					success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'DiagnosticOk' },
					failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'DiagnosticError' },
					danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'DiagnosticError' },
					bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'DiagnosticError' },
					quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = '@markup.quote' },
				},
				checkbox = {
					custom = {
						-- todo = { raw = '[-]', rendered = '󰥔 ', highlight = '@markup.raw' },
						rmk = { raw = '[!]', rendered = '󰳦 ', highlight = 'DiagnosticError' },
						important = { raw = '[*]', rendered = ' ', highlight = 'DiagnosticHint' },
						question = { raw = '[?]', rendered = '󰘥 ', highlight = 'DiagnosticWarn' },
						example = { raw = '[@]', rendered = '󰉹 ', highlight = 'DiagnosticHint' },
						tip = { raw = '[~]', rendered = '󰌶 ', highlight = 'DiagnosticOk' },
						wontdo = { raw = '[=]', rendered = '󰜺 ', highlight = '@markup.quote' },
						defer = { raw = '[>]', rendered = ' ', highlight = 'DiagnosticInfo' },
						pro = { raw = '[+]', rendered = ' ', highlight = 'DiagnosticOk' },
						con = { raw = '[-]', rendered = ' ', highlight = 'DiagnosticError' },
					},
				}
			})
		end,
	}
}
