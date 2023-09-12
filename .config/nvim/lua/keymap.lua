function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "zz", "za", { silent = true, noremap = true })
map("t", "<ESC>", "<C-\\><C-n>", { silent = true, noremap = true })

-- Telescope-coc
map("n", "<M-c>", ":Telescope coc<CR>", { silent = true, noremap = true })
vim.g.AutoPairsShortcutToggle = ''

-- Visual multi
vim.g.VM_maps = {}
vim.g.VM_maps = {
    ['Find Under'] = '<C-d>',
    ['Find Subword Under']= '<C-d>'
}

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})
