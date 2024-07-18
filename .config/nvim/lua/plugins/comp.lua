---@diagnostic disable: undefined-global

return {
	{
		'neoclide/coc.nvim',
		config = function()
			-- Some servers have issues with backup files, see #649
			vim.opt.backup = false
			vim.opt.writebackup = false

			-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
			-- delays and poor user experience
			vim.opt.updatetime = 300

			-- Always show the signcolumn, otherwise it would shift the text each time
			-- diagnostics appeared/became resolved
			-- vim.opt.signcolumn = "yes"

			local keyset = vim.keymap.set
			-- Autocomplete
			function _G.check_back_space()
				local col = vim.fn.col('.') - 1
				return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
			end
			local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

			-- WARNING: Comment out the following two lines if there were issues
			keyset("n", "<space>", "<NOP>", { silent = true, noremap = true })
			vim.g.mapleader = " "

			-- Completion
			keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
				opts)
			keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
			keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
			keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
			keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

			-- Navigation
			keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
			keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
			keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
			keyset("n", "<Leader><CR>", ":call CocActionAsync('jumpDefinition')<CR>", { silent = true })
			keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
			keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
			keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

			-- Refactor
			keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
			keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
			-- keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
			-- keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
			keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
			keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

			-- Code actions
			---@diagnostic disable-next-line: redefined-local
			local opts = { silent = true, nowait = true }
			keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts) -- Example: `<leader>aap` for current paragraph
			keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
			keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
			keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
			-- keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)
			keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)
			keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

			-- Function and class text objects
			keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
			keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
			keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
			keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
			keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
			keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
			keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
			keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

			-- Remap <C-f> and <C-b> to scroll float windows/popups
			---@diagnostic disable-next-line: redefined-local
			local opts = { silent = true, nowait = true, expr = true }
			keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
			keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
			keyset("i", "<C-f>",
				'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
			keyset("i", "<C-b>",
				'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
			keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
			keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

			-- Use CTRL-S for selections ranges
			keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
			keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

			-- Mappings for CoCList
			---@diagnostic disable-next-line: redefined-local
			-- local opts = { silent = true, nowait = true }
			-- Show all diagnostics
			-- keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
			-- -- Manage extensions
			-- keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
			-- -- Show commands
			-- keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
			-- -- Find symbol of current document
			-- keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
			-- -- Search workspace symbols
			-- keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
			-- -- Do default action for next item
			-- keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
			-- -- Do default action for previous item
			-- keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
			-- -- Resume latest coc list
			-- keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
			keyset("n", "gL", "<cmd>call coc#rpc#request('fillDiagnostics', [bufnr('%')])<CR><cmd>Trouble loclist<CR>`", { silent = true })

			-- Use K to show documentation in preview windowinit
			function _G.show_docs()
				local cw = vim.fn.expand('<cword>')
				if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
					vim.api.nvim_command('h ' .. cw)
				elseif vim.api.nvim_eval('coc#rpc#ready()') then
					vim.fn.CocActionAsync('doHover')
				else
					vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
				end
			end

			keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

			-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
			vim.api.nvim_create_augroup("CocGroup", {})
			vim.api.nvim_create_autocmd("CursorHold", {
				group = "CocGroup",
				command = "silent call CocActionAsync('highlight')",
				desc = "Highlight symbol under cursor on CursorHold"
			})

			-- Setup formatexpr specified filetype(s)
			vim.api.nvim_create_autocmd("FileType", {
				group = "CocGroup",
				pattern = "typescript,json",
				command = "setl formatexpr=CocAction('formatSelected')",
				desc = "Setup formatexpr specified filetype(s)."
			})

			-- Update signature help on jump placeholder
			vim.api.nvim_create_autocmd("User", {
				group = "CocGroup",
				pattern = "CocJumpPlaceholder",
				command = "call CocActionAsync('showSignatureHelp')",
				desc = "Update signature help on jump placeholder"
			})

			-- Add `:Format` command to format current buffer
			vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

			-- " Add `:Fold` command to fold current buffer
			vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

			-- Add `:OR` command for organize imports of the current buffer
			vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

			-- Add (Neo)Vim's native statusline support
			-- NOTE: Please see `:h coc-status` for integrations with external plugins that
			-- provide custom statusline: lightline.vim, vim-airline
			vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

		end
	},

	-- WARNING: Comment out the following plugin if there were issues
	--[[
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "mstanciu552/cmp-matlab" },
		config = function()
			local cmp = require 'cmp'
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					--['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.ini
					{ name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = 'buffer' },
				})
				-- }
			})

			-- Set configuration for specific filetype.
			cmp.setup.filetype('matlab', {
				sources = cmp.config.sources({
					{ name = 'cmp_matlab' },
				}, {
					{ name = 'buffer' },
				})
			})
			-- Set configuration for specific filetype.
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = 'buffer' },
				})
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			--cmp.setup.cmdline(':', {
			--mapping = cmp.mapping.preset.cmdline(),
			--sources = cmp.config.sources({
			--{ name = 'path' }
			--}, {
			--{ name = 'cmdline' }
			--})
			--})

			-- Setup lspconfig.
			-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
			-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
			-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
			-- capabilities = capabilities
			-- }

			-- Mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			local opts = { noremap = true, silent = true }
			-- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
			-- vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
			-- vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
			-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
				--  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
			end

			-- Use a loop to conveniently call 'setup' on multiple servers and
			-- map buffer local keybindings when the language server attaches
			--local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
			--for _, lsp in pairs(servers) do
			--  require('lspconfig')[lsp].setup {
			--    on_attach = on_attach,
			--    flags = {
			--      -- This will be the default in neovim 0.7+
			--      debounce_text_changes = 150,
			--    }
			--  }
			--end
		end
	},
--]]
	{
		'abecodes/tabout.nvim',
		event = 'VeryLazy',
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			-- "sirver/ultisnips",
			"github/copilot.vim",
			-- "zbirenbaum/copilot.lua",
			"neoclide/coc.nvim",
			"github/copilot.vim",
		},
		config = function()
			require 'tabout'.setup({
				tabkey = '<Tab>',         -- key to trigger tabout, set to an empty string to disable
				backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
				act_as_tab = true,        -- shift content if tab out is not possible
				act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
				default_tab = '<C-t>',    -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
				default_shift_tab = '<C-d>', -- reverse shift default action,
				enable_backwards = true,  -- well ...
				completion = true,        -- if the tabkey is used in a completion pum
				tabouts = {
					{ open = "'", close = "'" },
					{ open = '"', close = '"' },
					{ open = '`', close = '`' },
					{ open = '(', close = ')' },
					{ open = '[', close = ']' },
					{ open = '{', close = '}' },
					{ open = '{', close = '}' },
					{ open = '$', close = '$' }
				},
				ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
				exclude = {} -- tabout will ignore these filetypes
			})

			-- handle <Tab> key to prioritize LuaSnip over Tabout
			local ls = require('luasnip')

			local function replace_keycodes(c)
				return vim.api.nvim_replace_termcodes(c, true, true, true)
			end

			function _G.tab_binding()
				if ls.expand_or_jumpable() then
					return replace_keycodes('<Plug>luasnip-expand-or-jump')
				elseif vim.fn['coc#pum#visible']() == 1 then
					return vim.fn['coc#pum#next'](1)
				else
					return replace_keycodes('<Plug>(Tabout)')
				end
			end

			function _G.s_tab_binding()
				if ls.jumpable(-1) then
					return replace_keycodes('<Plug>luasnip-jump-prev')
				elseif vim.fn['coc#pum#visible']() == 1 then
					return vim.fn['coc#pum#prev'](1)
				else
					return replace_keycodes('<Plug>(TaboutBack)')
				end
			end

			vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_binding()', { expr = true })
			vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_binding()', { expr = true })
		end
	}
}
