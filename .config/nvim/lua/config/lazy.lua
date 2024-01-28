local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { silent = true, noremap = true })
--vim.cmd [[let maplocalleader="<space>"]]
vim.g.maplocalleader = " "
vim.g.mapleader = " "

require('lazy').setup({
  spec = {
		-- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "../lazies" }
  },
  ui = { border = "rounded" },
})
