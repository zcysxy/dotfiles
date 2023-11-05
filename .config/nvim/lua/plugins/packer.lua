local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require 'packer'
local util = require 'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

return packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- Themes
  use 'cormacrelf/dark-notify'
  use "rebelot/kanagawa.nvim"
  use "sainnhe/gruvbox-material"
  use { "savq/melange-nvim" }
  use 'rmehri01/onenord.nvim'
  use 'Th3Whit3Wolf/one-nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use({ 'projekt0n/github-nvim-theme', tag = 'v0.0.7' })
  use { 'uloco/bluloco.nvim',
    requires = { 'rktjmp/lush.nvim' } }
  use {
    "svermeulen/text-to-colorscheme.nvim",
    config = function()
      require('text-to-colorscheme').setup {
        ai = {
          gpt_model = "gpt-3.5-turbo",
        }
      }
    end

  }
  use { 'xiyaowong/nvim-transparent' }

  -- Plugins
  -- Search and Telescope
  use { 'fannheyward/telescope-coc.nvim',
    config = function()
      require("telescope").setup({
        extensions = {
          coc = {
            --theme = 'ivy',
            --prefer_locations = false, -- always use Telescope locations to preview definitions/declarations/implementations etc
          }
        },
      })
      require('telescope').load_extension('coc')
    end }
  use({
    "hrsh7th/nvim-cmp",
    requires = { "mstanciu552/cmp-matlab" },
  })
  use { 'junegunn/fzf', run = ":call fzf#install()" }
  use { 'junegunn/fzf.vim' }
  use {
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
  }
  use { "LinArcX/telescope-command-palette.nvim" }

  -- Shell and Terminal
  use 'eandrju/cellular-automaton.nvim'
  use "nvim-lua/plenary.nvim"

  -- UI
  use 'sindrets/winshift.nvim'
  use { 'folke/trouble.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    conifg = function()
      require("trouble").setup {
        icon = false,
      }
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  -- use {
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
  -- }
  use {
    'goolord/alpha-nvim',
    config = function()
      require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
    end
  }
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-fugitive'
  use {
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
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
  }

  -- Editing
  use { 'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use { 'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>',                 -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>',     -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true,                -- shift content if tab out is not possible
        act_as_shift_tab = false,         -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>',            -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>',      -- reverse shift default action,
        enable_backwards = true,          -- well ...
        completion = true,                -- if the tabkey is used in a completion pum
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
        exclude = {}     -- tabout will ignore these filetypes
      }
    end,
    wants = { 'nvim-treesitter' },
    after = { 'nvim-cmp' }, }
  use { 'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  }

  -- AI
  use 'github/copilot.vim'
  use 'madox2/vim-ai'

  -- Languages
  use { 'neoclide/coc.nvim', branch = 'release' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Python
  use { 'jupyter-vim/jupyter-vim' }
  use { 'goerz/jupytext.vim' }
  use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

  -- Markdown
  --use 'godlygeek/tabular'
  use 'preservim/vim-markdown'
  use({
    "michaelb/sniprun",
    run = "sh ./install.sh",
  })
  --use { 'nvim-tree/nvim-tree.lua' }
  --use 'daeyun/vim-matlab'
  use 'WENLIXIAO-CS/vim-matlab'
  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    -- tag = "v<CurrentMajor>.*",
    -- install jsregexp (optional!:).
    version = "2.*",
    config = function()
      local ls = require 'luasnip';
      ls.setup({ enable_autosnippets = true })
    end,
    run = "make install_jsregexp"
  })
  use "lervag/vimtex"
  -- use {
  --   "iurimateus/luasnip-latex-snippets.nvim",
  --   -- branch = 'fix/lazy-loading',
  --   -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
  --   -- using treesitter.
  --   --requires = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
  --   requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
  --   config = function()
  --     require'luasnip-latex-snippets'.setup({use_treesitter = false})
  --   end,
  --   -- treesitter is required for markdown
  -- }
  use 'sirver/ultisnips'
  -- use 'vim-pandoc/vim-pandoc'
  -- use 'vim-pandoc/vim-pandoc-syntax'

  -- use 'DaikyXendo/nvim-material-icon'
  -- use ({'nvim-tree/nvim-web-devicons',
  --     config = function ()
  --         require'nvim-web-devicons'.setup()
  --     end
  -- })
  -- Other languages
  use 'chrisbra/csv.vim'
end)
