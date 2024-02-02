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
}
