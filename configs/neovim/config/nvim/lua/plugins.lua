
-- Bootstrap packer {{{
local fn = vim.fn

local install_path = fn.stdpath("data") .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd('packadd packer.nvim')
end
-- }}}

return require 'packer'.startup{function(use)

    use 'wbthomason/packer.nvim'

    use { 'elliottt/two-trucs', run = 'make release' }

    use { 'junegunn/fzf', run = './install --bin' }

    use 'junegunn/fzf.vim'


    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use 'neovim/nvim-lspconfig'
    use {
        'glepnir/lspsaga.nvim',
        requires = {'neovim/nvim-lspconfig'},
    }

    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }

    use 'mhinz/vim-sayonara'

    use 'sainnhe/sonokai'

    use {
        'kdheepak/tabline.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true }
    }

end,
config = {
    display = {
        open_fn = require('packer.util').float,
    },
}}
