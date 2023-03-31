vim.cmd([[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
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
