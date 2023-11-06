local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.g.maplocalleader = " "
vim.g.mapleader = " "

require('lazy').setup({
    -- Themes
    'cormacrelf/dark-notify',
    'rebelot/kanagawa.nvim',
    'sainnhe/gruvbox-material',
    'savq/melange-nvim',
    'rmehri01/onenord.nvim',
    'Th3Whit3Wolf/one-nvim',
    { 'catppuccin/nvim',             name = 'catppuccin' },
    { 'projekt0n/github-nvim-theme', version = 'v0.0.7' },
    {
        'uloco/bluloco.nvim',
        dependencies = { 'rktjmp/lush.nvim' }
    },
    {
        "svermeulen/text-to-colorscheme.nvim",
        config = function()
            require('text-to-colorscheme').setup {
                ai = {
                    gpt_model = "gpt-3.5-turbo",
                }
            }
        end

    },
    'xiyaowong/nvim-transparent',

    -- Plugins
    -- Search and Telescope
    'fannheyward/telescope-coc.nvim',
    'catgoose/telescope-helpgrep.nvim',
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "mstanciu552/cmp-matlab" },
    },
    { 'junegunn/fzf',      build = ":call fzf#install()" },
    'junegunn/fzf.vim',
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require('telescope').setup {
                pickers = {
                    colorscheme = {
                        enable_preview = true,
                    },
                }
            }
        end
    },
    'LinArcX/telescope-command-palette.nvim',

    -- Shell and Terminal
    'eandrju/cellular-automaton.nvim',
    'nvim-lua/plenary.nvim',

    -- UI
    'sindrets/winshift.nvim',
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        conifg = function()
            require("trouble").setup {
                icon = false,
            }
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    -- {
    --   "folke/which-key.nvim",
    --   config = function()
    --     vim.o.timeout = true
    --     vim.o.timeoutlen = 300
    --     require("which-key").setup {
    --       -- your configuration comes here
    --       -- or leave it empty to use the default settings
    --       -- refer to the configuration section below
    --     }
    --   end
    -- },
    {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end
    },
    'airblade/vim-gitgutter',
    'tpope/vim-fugitive',
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('todo-comments').setup({
                highlight = {
                    pattern = [[.*<(KEYWORDS)\s*]],
                },
                search = {
                    pattern = [[\b(KEYWORDS)\b]],
                },
            })
        end
    },

    -- Editing
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<Tab>',     -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true,    -- shift content if tab out is not possible
                act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                default_shift_tab = '<C-d>', -- reverse shift default action,
                enable_backwards = true, -- well ...
                completion = true,    -- if the tabkey is used in a completion pum
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = '`', close = '`' },
                    { open = '(', close = ')' },
                    { open = '[', close = ']' },
                    { open = '{', close = '}' },
                    { open = '$', close = '$' }
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
            }
        end,
        dependencies = { 'nvim-cmp' },
    },
    {
        'ggandor/leap.nvim',
        config = function()
            require('leap').add_default_mappings()
        end
    },

    -- AI
    'github/copilot.vim',
    'madox2/vim-ai',

    -- Languages
    { 'neoclide/coc.nvim', branch = 'release' },
    'nvim-treesitter/nvim-treesitter',

    -- Python
    'jupyter-vim/jupyter-vim',
    'goerz/jupytext.vim',
    'dccsillag/magma-nvim',
    build = ':UpdateRemotePlugins',

    -- Markdown
    --'godlygeek/tabular',
    'preservim/vim-markdown',
    {
        "michaelb/sniprun",
        build = "sh ./install.sh",
    },
    --'nvim-tree/nvim-tree.lua',
    --'daeyun/vim-matlab',
    -- 'WENLIXIAO-CS/vim-matlab', --TODO: to update
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        -- version = "v<CurrentMajor>.*",
        -- install jsregexp (optional!:).
        version = "2.*",
        config = function()
            local ls = require 'luasnip';
            ls.setup({ enable_autosnippets = true })
        end,
        build = "make install_jsregexp"
    },
    'lervag/vimtex',
    -- use {
    --   "iurimateus/luasnip-latex-snippets.nvim",
    --   -- branch = 'fix/lazy-loading',
    --   -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
    --   -- using treesitter.
    --   --dependencies = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
    --   dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    --   config = function()
    --     require'luasnip-latex-snippets'.setup({use_treesitter = false})
    --   end,
    --   -- treesitter is required for markdown
    -- }
    'sirver/ultisnips',
    -- 'vim-pandoc/vim-pandoc',
    -- 'vim-pandoc/vim-pandoc-syntax',

    -- 'DaikyXendo/nvim-material-icon',
    -- use ({'nvim-tree/nvim-web-devicons',
    --     config = function ()
    --         require'nvim-web-devicons'.setup()
    --     end
    -- })
    -- Other languages
    'chrisbra/csv.vim',

    -- " Plug 'https://github.com/vim-airline/vim-airline'
    'https://github.com/preservim/nerdtree',
    'https://github.com/preservim/tagbar',
    'https://github.com/neovim/nvim-lspconfig',
    -- " Plug 'https://github.com/preservim/nerdcommenter'
    'https://github.com/tpope/vim-surround',
    'https://github.com/jiangmiao/auto-pairs',
    { 'mg979/vim-visual-multi', branch = 'master' },
    'jupyter-vim/jupyter-vim',
})
