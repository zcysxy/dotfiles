---@diagnostic disable: undefined-global
return {
  'LazyVim/LazyVim',

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
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      require('bluloco').setup({ transparent = true, italics = true })
    end
  },
  { 'xiyaowong/transparent.nvim', lazy = false },

  -- Plugins
	-- Meta
  'mrquantumcodes/retrospect.nvim',
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "mstanciu552/cmp-matlab" },
	},

  -- Shell and Terminal
  'eandrju/cellular-automaton.nvim',
  'nvim-lua/plenary.nvim',

  -- UI
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function() require('ibl').setup() end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "neovim/nvim-lspconfig",
      "luukvbaal/statuscol.nvim",
    },
  },
  {
    "luukvbaal/statuscol.nvim",
		config = function()
      local builtin = require "statuscol.builtin"
      require("statuscol").setup {
        -- relculright = true,
        -- segments = {
        --   { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
        --   { text = { "%s" },                  click = "v:lua.ScSa" },
        --   { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
        -- },
      }
    end,
  },
  'sindrets/winshift.nvim',
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    conifg = function()
      require("trouble").setup {
        icon = true,
      }
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    config = function()
      require('lualine').setup({
        options = {
          disabled_filetypes = { 'alpha' }
        },
        sections = {
          lualine_c = { { 'filename', path = 1 } }
        }
      })
    end
  },
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
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
  "j-hui/fidget.nvim",
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end
  },

  -- Editing
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup()
    end
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },


  -- Languages
  --lsp
  'neovim/nvim-lspconfig',
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    event = 'LspAttach',
    opts = {
      ui = { border = 'rounded' },
      symbol_in_winbar = {
        enable = true,
        folder_level = 2,
      },
      lightbulb = {
        enable = false,
        sign = false,
      },
      outline = {
        layout = 'float',
        max_height = 0.7,
        left_width = 0.4,
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
      {
        '<leader>gr',
        '<Cmd>Lspsaga rename<CR>',
        mode = 'n',
        noremap = true,
        silent = true,
        desc = 'Rename (lspsaga)',
      },
      {
        '<leader>go',
        '<Cmd>Lspsaga outline<CR>',
        mode = 'n',
        noremap = true,
        silent = true,
        desc = "Show file outline (lspsaga) - 'e' to jump, 'o' to toggle",
      },
      {
        '<leader>ga',
        '<cmd>Lspsaga code_action<CR>',
        mode = { 'n', 'v' },
        desc = 'Show code action (lspsaga)',
      },
    },
  },
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
    opts = {
      repl_enable = { "python", "lua", "bash", "javascript", "octave", "matlab", "R_original" },
    }
  },
  {
    "frabjous/knap",
    ft = { "markdown" },
  },

  --'nvim-tree/nvim-tree.lua',
  --'daeyun/vim-matlab',
  -- 'WENLIXIAO-CS/vim-matlab', --TODO: to update
  'lervag/vimtex',
  -- { 'sirver/ultisnips', ft = {"markdown", "tex"} },
  -- {
  --   'vim-pandoc/vim-pandoc',
  --   config = function()
  --     vim.g['pandoc#biblio#bibs'] = { '/Users/ce/3-KNWL/33-Ref/myLibrary.bib' };
  --     vim.g['pandoc#modules#disabled'] = { 'keyboard' }
		-- 	vim.g['pandoc#filetypes#handled'] = { 'pandoc', 'markdown' }
  --     vim.g['pandoc#filetypes#pandoc_markdown'] = 0
  --   end
  -- },
  -- 'vim-pandoc/vim-pandoc-syntax',
  {
    'aspeddro/cmp-pandoc.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('cmp').setup {
        sources = {
          { name = 'pandoc' },
        },
      }
      require('cmp_pandoc').setup()
    end
  },

  -- 'DaikyXendo/nvim-material-icon',
  -- use ({'nvim-tree/nvim-web-devicons',
  --     config = function ()
  --         require'nvim-web-devicons'.setup()
  --     end
  -- })

  -- HTML
  'AndrewRadev/tagalong.vim',

  -- Other languages
  'chrisbra/csv.vim',

  -- " Plug 'https://github.com/vim-airline/vim-airline'
  'https://github.com/preservim/nerdtree',
  'https://github.com/preservim/tagbar',
  -- " Plug 'https://github.com/preservim/nerdcommenter'
  'https://github.com/tpope/vim-surround',
  'https://github.com/jiangmiao/auto-pairs',
  { 'mg979/vim-visual-multi', branch = 'master' },
  'jupyter-vim/jupyter-vim',
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
      "neoclide/coc.nvim"
    },
  },
}
