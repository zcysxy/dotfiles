-- require 'plugins.packer'
require 'plugins.magma'
require 'plugins.jupyter'
require 'plugins.alpha'
require 'plugins.markdown'
require 'plugins.knap'
-- require 'plugins.tree'
-- require 'plugins.icon'
require 'plugins.tele'
require 'plugins.coc'
-- require 'plugins.cmp'
require 'plugins.treesitter'
require 'plugins.tex'
require 'plugins.luasnip'
require 'plugins.tabout'

-- CSV
vim.g.csv_arrange_align = 'l*'

-- imap <silent><expr> <TAB> copilot#Accept({ -> !coc#pum#visible() ? "<Plug>(Tabout)" : luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' })
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
