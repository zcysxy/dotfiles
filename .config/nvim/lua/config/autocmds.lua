local vim = vim
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Appearance
local transparent = augroup("transparent", {})
autocmd("ColorScheme", {
	pattern = { "*" },
	callback = function()
		local groups = {
			"Normal",
			"NormalNC",
			"NormalSB",
			"NormalFloat",
			"FloatBorder",
			"FloatTitle",
			"TelescopeNormal",
			"TelescopeBorder",
			"Conceal",
			"NvimTreeNormal",
			"NvimTreeCursorLine",
			"NotifyBackground",
			"NeoTreeNormal",
			"NeoTree",
			"NeoTreeEndOfBuffer",
		}
		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { ctermbg = "NONE", bg = "NONE" })
			-- vim.api.nvim_command("redraw")
		end
		-- vim.api.nvim_set_hl(0, "Visual", { reverse = true, cterm = { reverse = true }, fg = "Grey" })
		local notify = {
			"NotifyINFOBorder",
			"NotifyERRORBorder",
			"NotifyWARNBorder",
		}
		for _, group in ipairs(notify) do
			vim.cmd("hi! " .. group .. " guibg=NONE ctermbg=NONE")
		end
	end,
	group = transparent,
})

-- Enable folds
autocmd({ "BufEnter" }, {
	pattern = { "*" },
	command = "normal zx",
})

-- Highlight yanked text
local highlightYank = augroup("highlightYank", {})
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
	end,
	group = highlightYank,
})

-- Jump to last position when opening a file
local misc_augroup = vim.api.nvim_create_augroup('misc', {})
autocmd('BufReadPost', {
	desc = 'Open file at the last position it was edited earlier',
	group = misc_augroup,
	pattern = '*',
	command = 'silent! normal! g`"zv'
})

vim.api.nvim_create_user_command("Messages", function()
	local bufnr = vim.api.nvim_create_buf(false, true)
	vim.bo[bufnr].buftype = "vim"
	vim.api.nvim_buf_call(bufnr, function()
		vim.cmd([[put= execute('messages')]])
	end)
	vim.api.nvim_buf_set_option(bufnr, "modifiable", false)
	vim.cmd.split()
	local winnr = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(winnr, bufnr)
end, {})

-- Save folds
-- autocmd({"BufWinLeave"}, {
--   pattern = {"*.*"},
--   desc = "save view (folds), when closing file",
--   command = "mkview",
-- })
-- autocmd({"BufWinEnter"}, {
--   pattern = {"*.*"},
--   desc = "load view (folds), when opening file",
--   command = "silent! loadview"
-- })

-- For all text files set 'textwidth' to 78 characters.
local vimrcEx = augroup("vimrcEx", {})
autocmd("FileType", {
	pattern = { "text" },
	callback = function()
		vim.bo.textwidth = 78
	end,
	group = vimrcEx,
})

-- Clear notifications
autocmd({ "InsertEnter" }, {
	group = vim.api.nvim_create_augroup("NotifyClearGrp", {}),
	pattern = "*",
	callback = function()
		require("notify").dismiss({ silent = true })
	end
})

-- Stop dynamic folding
-- autocmd({ "InsertLeave", "WinEnter" }, {
-- 	pattern = "*",
-- 	command = "setlocal foldmethod=syntax",
-- })
-- autocmd({ "InsertEnter", "WinLeave" }, {
-- 	pattern = "*",
-- 	command = "setlocal foldmethod=manual",
-- })
