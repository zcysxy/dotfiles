function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "zz", "za", { silent = true, noremap = true })
map("t", "<ESC>", "<C-\\><C-n>", { silent = true, noremap = true })

-- Visual multi
vim.g.VM_maps = {}
vim.g.VM_maps = {
    ['Find Under'] = '<C-d>',
    ['Find Subword Under']= '<C-d>'
}

