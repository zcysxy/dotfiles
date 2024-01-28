local ls = require("luasnip")
local keyset = vim.keymap.set

keyset({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
keyset({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
keyset({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : v:lua.check_back_space() ? '<Tab>' : coc#refresh()", opts)
-- keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
-- keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

vim.cmd([[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
" imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

]])
--   use {
--     'iurimateus/luasnip-latex-snippets.nvim',
--     requires = { 'L3MON4D3/LuaSnip', 'lervag/vimtex' },
--     config = function()
--       require'luasnip-latex-snippets'.setup()
--
--       -- Modify existing snippets using higher priority and util function from luasnip-latex-snippets
--       local ls = require("luasnip")
--       local s = ls.snippet
--       local i = ls.insert_node
--       local fmta = require("luasnip.extras.fmt").fmta
--       local utils = require("luasnip-latex-snippets.util.utils")
--       local not_math = utils.with_opts(utils.not_math, false) -- when using treesitter, change false to true
--
--       ls.add_snippets("tex", {
--         s({trig = "mk", snippetType="autosnippet", priority=100},
--           fmta("$<>$<>", { i(1), i(2), }), {condition = not_math}
--         ),
--         -- ...
--       })
--     end,
--     ft = "tex",
--   }

require("luasnip.loaders.from_snipmate").load({ include = { "markdown" } })

