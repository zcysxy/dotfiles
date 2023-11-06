require("telescope").setup({
extensions = {
  coc = {},
  helpgrep = {}
},
})
require('telescope').load_extension('coc')
require('telescope').load_extension('helpgrep')

local map = vim.keymap.set
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map('n', '<leader>t', function()
  require('telescope.builtin').builtin { include_extensions = true }
end)
map('n', '<C-p>', ':Telescope commands<CR>')
map('n', '<leader>o', ':Telescope find_files<CR>')
-- nnoremap <Leader>r :Rg<CR>
map('n', '<leader>r', ':Telescope live_grep<CR>')
-- nnoremap <A-p> :Commands<CR>

