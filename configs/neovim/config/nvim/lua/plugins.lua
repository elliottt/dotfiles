
-- Bootstrap packer {{{
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end
-- }}}

return require 'packer'.startup(function(use)

    use { 'wbthomason/packer.nvim' }

    use { 'elliottt/two-trucs', run = 'make release' }

    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'

    use 'junegunn/seoul256.vim'

    use {
        'vim-airline/vim-airline',
        requires = { 'vim-airline/vim-airline-themes' },
        ensure_dependencies = true,
        config = function()
            vim.cmd([[
                set laststatus=2

                let g:airline_powerline_fonts = 1
                let g:airline#extensions#tabline#enabled = 1
                let g:airline_theme = 'bubblegum'
                let g:airline#extensions#whitespace#enabled = 0
            ]])
        end,
    }

    use 'nvim-treesitter/nvim-treesitter'
    use 'neovim/nvim-lspconfig'

    use 'benmills/vimux'

    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    use 'mhinz/vim-sayonara'

end)
