vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "latex" },
  callback = function()
    require("ufo").detach()
    vim.opt_local.foldenable = false
  end
})
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.cmd("UfoDetach")
map("n", "<C-CR>", ":VimtexCompile<CR>", { silent = true})
vim.o.foldmethod = "expr"
vim.o.foldexpr = "vimtex#fold#level(v:lnum)"
vim.o.foldtext = "vimtex#fold#text()"
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "vimtex#fold#level(v:lnum)"
vim.wo.foldtext = "vimtex#fold#text()"
