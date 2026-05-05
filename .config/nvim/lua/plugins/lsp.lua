return {
	-- NOTE: Checkout lsp-zero
	{
		'neovim/nvim-lspconfig',
		keys = {
			{ "<leader><CR>", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Jump to definition" },
			{
				"K",
				function()
					vim.lsp.buf.hover()
					vim.diagnostic.open_float(nil, { focusable = false })
				end,
				desc = "Show hover information"
			},
			-- {
			-- 	"<leader>a",
			-- 	"<cmd>lua vim.lsp.buf.code_action()<CR>",
			-- 	mode = { "n", "x" },
			-- 	desc = "Show actions"
			-- },
		},
		config = function()
			vim.api.nvim_create_user_command("Format", "lua vim.lsp.buf.format { async = true, timeout_ms = 5000 }",
				{ desc = "Format current buffer with LSP" })
		end
	},
	{ 'mason-org/mason.nvim', opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
			},
			automatic_installation = true,
		},
	},
	{
		'nvimdev/lspsaga.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			{ 'nvim-tree/nvim-web-devicons', lazy = true },
		},
		event = 'LspAttach',
		opts = {
			ui = {
				border = 'rounded',
				title = false
			},
			symbol_in_winbar = {
				enable = true,
				folder_level = 2,
			},
			lightbulb = {
				enable = false,
				sign = false,
			},
			outline = {
				layout = 'normal',
				-- max_height = 0.7,
				-- left_width = 0.4,
			},
			code_action = {
				num_shortcut = true,
				show_server_name = true,
			},
		},
		keys = {
			{
				'<leader>gj',
				'<Cmd>Lspsaga diagnostic_jump_next<CR>',
				mode = 'n',
				noremap = true,
				silent = true,
				desc = 'Diagnostics: Jump next (lspsaga)',
			},
			{
				'<leader>gh',
				'<Cmd>Lspsaga hover_doc<CR>',
				mode = 'n',
				noremap = true,
				silent = true,
				desc = 'Documentation on hover (lspsaga)'
			},
			{
				'<leader>gl',
				'<Cmd>Lspsaga show_line_diagnostics<CR>',
				mode = 'n',
				noremap = true,
				silent = true,
				desc = "Diagnostics: Show line's (lspsaga)",
			},
			{
				'<leader>gb',
				'<Cmd>Lspsaga show_buf_diagnostics<CR>',
				mode = 'n',
				noremap = true,
				silent = true,
				desc = "Diagnostics: Show buffer's (lspsaga)",
			},
			{
				'<leader>gf',
				'<Cmd>Lspsaga finder<CR>',
				mode = 'n',
				noremap = true,
				silent = true,
				desc = 'Find references (lspsaga)',
			},
			{
				'<leader>gp',
				'<Cmd>Lspsaga peek_definition<CR>',
				mode = 'n',
				noremap = true,
				silent = true,
				desc = 'Peek definition (lspsaga)',
			},
			{
				'<leader>gt',
				'<Cmd>Lspsaga peek_type_definition<CR>',
				mode = 'n',
				noremap = true,
				silent = true,
				desc = 'Peek type definition (lspsaga)',
			},
			-- {
			-- 	'<leader>gr',
			-- 	'<Cmd>Lspsaga rename<CR>',
			-- 	mode = 'n',
			-- 	noremap = true,
			-- 	silent = true,
			-- 	desc = 'Rename (lspsaga)',
			-- },
			{
				'<leader>go',
				'<Cmd>Lspsaga outline<CR>',
				mode = 'n',
				noremap = true,
				silent = true,
				desc = "Show file outline (lspsaga) - 'e' to jump, 'o' to toggle",
			},
			{
				'<leader>a',
				'<cmd>Lspsaga code_action<CR>',
				mode = { 'n', 'v' },
				desc = 'Show code action (lspsaga)',
			},
		},
	},
	{
		"barreiroleo/ltex_extra.nvim",
		branch = "dev",
		ft = { "markdown", "tex" },
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {
			load_langs = { "en-US" },
			path = ".ltex"
		}
	},
}
