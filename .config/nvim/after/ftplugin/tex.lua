function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<C-CR>", ":VimtexCompile<CR>", { silent = true})
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "vimtex#fold#level(v:lnum)"
vim.wo.foldtext = "vimtex#fold#text()"
