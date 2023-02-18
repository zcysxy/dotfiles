local vim = vim

local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

return packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }
    -- Themes
	use { "savq/melange-nvim" }
    use { 'junegunn/fzf', run = ":call fzf#install()" }
    use { 'junegunn/fzf.vim' }
    use 'eandrju/cellular-automaton.nvim'
    use 'rmehri01/onenord.nvim'
    use 'Th3Whit3Wolf/one-nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use ({ 'projekt0n/github-nvim-theme', tag = 'v0.0.7' })

    -- Plugins
	use "nvim-lua/plenary.nvim"
	use { "nvim-telescope/telescope.nvim" }
	use { "LinArcX/telescope-command-palette.nvim" }
    use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'jupyter-vim/jupyter-vim' }
    use { 'goerz/jupytext.vim' }
    use { 'xiyaowong/nvim-transparent' }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    --use {
      --"folke/which-key.nvim",
      --config = function()
        --vim.o.timeout = true
        ----vim.o.timeoutlen = 300
        --require("which-key").setup{
            ----
        --}
      --end
    --}
    use {
      'goolord/alpha-nvim',
      config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end
    }
    use 'airblade/vim-gitgutter'

    -- Markdown
    --use 'godlygeek/tabular'
    use 'preservim/vim-markdown'
    --use { 'nvim-tree/nvim-tree.lua' }

    use { 'neoclide/coc.nvim', branch = 'release' }
    use({ "hrsh7th/nvim-cmp",
            requires = { "mstanciu552/cmp-matlab" },
		})
    use { 'abecodes/tabout.nvim',
        wants = {'nvim-treesitter'},
        after = {'nvim-cmp'}, }
end)

