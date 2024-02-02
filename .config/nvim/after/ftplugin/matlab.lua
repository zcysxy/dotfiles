---@diagnostic disable: undefined-global
vim.b.slime_cell_delimiter = "%%"
vim.api.nvim_set_keymap("n", "]]", "<Plug>SlimeCellsNext", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[[", "<Plug>SlimeCellsPrev", { noremap = true, silent = true })
