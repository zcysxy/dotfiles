---@diagnostic disable: undefined-global

-- BlockFolds equivalent in Lua for Neovim
local function block_folds(lnum)
  local thisline = vim.fn.getline(lnum)
  if string.find(thisline, '# %%') then
    return '>1'
  else
    return '='
  end
end

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.BlockFolds()'
vim.opt.foldenable = false -- Disable folding at startup

vim.keymap.set({ 'n' }, '<leader>ll', function ()
	-- Check if the current buffer is has an extension of .ipynb
	local buf_name = vim.api.nvim_buf_get_name(0)
	if buf_name:match('%.ipynb$') then
	vim.cmd('JupyterRunFile')
	else
		vim.cmd('SlimeSend0')
	end
end)

-- Register the function globally for foldexpr
_G.BlockFolds = block_folds
