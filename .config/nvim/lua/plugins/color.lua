return {
	-- Colorschemes
	'sainnhe/gruvbox-material',
	'catppuccin/nvim',
	'rebelot/kanagawa.nvim',
	'savq/melange-nvim',
	'rmehri01/onenord.nvim',
	'Th3Whit3Wolf/one-nvim',
	'projekt0n/github-nvim-theme',
	{
		'uloco/bluloco.nvim',
		lazy = false,
		priority = 1000,
		dependencies = { 'rktjmp/lush.nvim' },
		config = function()
			require('bluloco').setup({ transparent = true, italics = true })
		end
	},

	-- Utils
	'cormacrelf/dark-notify',
	{ 'xiyaowong/transparent.nvim', lazy = false },

	-- AI
	{
		"svermeulen/text-to-colorscheme.nvim",
		config = function()
			require('text-to-colorscheme').setup {
				ai = {
					gpt_model = "gpt-4",
				},
				hex_palettes = {
					{
						name = "Gray Salt",
						background_mode = "dark",
						background = "#2b2b2b",
						foreground = "#f5f5f5",
						accents = {
							"#839091",
							"#bdc3c7",
							"#95a5a6",
							"#f39c12",
							"#e74c3c",
							"#3498db",
							"#27ad60",
						}
					},
					{
						name = "Salt Forest",
						background_mode = "dark",
						background = "#1b262c",
						foreground = "#a5b8b2",
						accents = {
							"#4d8f80",
							"#8bbda4",
							"#c4d3cf",
							"#ff7e67",
							"#927976",
							"#857792",
							"#676c92",
						}
					},
					{
						name = "mean field game",
						background_mode = "dark",
						background = "#1a1a1a",
						foreground = "#f2f2f2",
						accents = {
							"#ff6b6b",
							"#ffd166",
							"#05b688",
							"#118ab2",
							"#0c6380",
							"#ef476f",
							"#ffd166",
						}
					},
					{
						name = "Obsidian",
						background_mode = "dark",
						background = "#1c1e26",
						foreground = "#c0caf5",
						accents = {
							"#f7768e",
							"#86af5a",
							"#e0af68",
							"#78dce8",
							"#ab9df2",
							"#7dcfff",
							"#ff5370",
						}
					},
					{
						name = "ocean sunset",
						background_mode = "dark",
						background = "#1c2331",
						foreground = "#d8dde8",
						accents = {
							"#f7768e",
							"#f7c46c",
							"#6cbaac",
							"#b2b2b2",
							"#f5a5fc",
							"#8be9fd",
							"#ff6e6e",
						}
					}
				},
				default_palette = "Obsidian",
			}
		end
	}
}
