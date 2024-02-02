---@diagnostic disable: undefined-global

local map = function(mode, lhs, rhs, opts)
	local options = { silent = true, noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Basic
map("i", "jk", "<ESC>")
map("n", "j", "gj")
map("n", "gj", "j")
map("n", "k", "gk")
map("n", "gk", "k")
map("n", "H", "^")
map("n", "L", "$")
-- nmap J <C-D>
-- nmap K <C-U>
map("n", "<S-CR>", "i<CR><ESC>0") -- break line

-- Move lines up/down
map("n", "<C-j>", ":m .+1<CR>==")
map("n", "<C-k>", ":m .-2<CR>==")
map("i", "<C-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<C-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- delete line
map("n", "<BS>", "ddkk")

-- Move between buffers
map("n", "<leader>n", ":bnext<CR>")
map("n", "<leader>p", ":bprevious<CR>")
-- map("n", "<leader>d", ":bdelete<CR>")
map("n", "<leader>d", ":bp<bar>sp<bar>bn<bar>bd<CR>")

-- Execute code
map("n", "<C-CR>", ":r!./%<CR>")

map("n", "zz", "za", { silent = true, noremap = true })
map("t", "<ESC>", "<C-\\><C-n>", { silent = true, noremap = true })

-- Clipboard
map("x", "<leader>xp", '"+y', { silent = true, noremap = true })

-- Telescope-coc
map("n", "<M-c>", ":Telescope coc<CR>", { silent = true, noremap = true })
vim.g.AutoPairsShortcutToggle = ''

-- Visual multi
vim.g.VM_maps = {}
vim.g.VM_maps = {
	['Find Under'] = '<C-d>',
	['Find Subword Under'] = '<C-d>'
}
vim.g.VM_maps['Find Under'] = '<C-d>'
vim.g.VM_maps['Find Subword Under'] = '<C-d>'

-- GitGutter
map("n", "<C-g>r", ":GitGutterUndoHunk<CR>", { silent = true, noremap = true })
map("n", "<C-g>s", ":GitGutterStageHunk<CR>", { silent = true, noremap = true })

-- SnipRun
map('v', 'f', '<Plug>SnipRun', { silent = true })
map('n', '<leader>f', '<Plug>SnipRunOperator', { silent = true })
map('n', '<leader>ff', '<Plug>SnipRun', { silent = true })

-- Clear notifications
vim.keymap.set('n', '<c-x>', function() require("notify").dismiss({ silent = true }) end, { silent = true, noremap = true }
)

