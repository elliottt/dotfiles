
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
        'folke/which-key.nvim',
        config = function()
            require 'which-key'.setup()
        end
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end,
    }

    use 'mhinz/vim-sayonara'

    -- colorschemes
    use {
        'rebelot/kanagawa.nvim',
        disable = false,
        config = function()
            require 'kanagawa'.setup{ transparent = true }
            vim.cmd([[
                colorscheme kanagawa
            ]])
        end
    }

    use {
        'sainnhe/sonokai',
        disable = true,
        config = function()
            print('loading config')
            vim.cmd([[
                let g:sonokai_transparent_background = 1
                let g:sonokai_style = 'atlantis'
                colorscheme sonokai
            ]])
        end,
    }

    use {
        'kdheepak/tabline.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
        after = {'sonokai', 'kanagawa.nvim'},
        config = function()
            require 'tabline'.setup { enable = false }
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true },
        after = {'tabline.nvim'},
        config = function()
            local tabline = require('tabline')
            require 'lualine'.setup {
                options = {
                    icons_enabled = false,
                    theme = 'seoul256',
                },
                tabline = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { tabline.tabline_buffers },
                    lualine_x = { tabline.tabline_tabs },
                    lualine_y = {},
                    lualine_z = {},
                }
            }
        end,
    }

end,
config = {
    display = {
        open_fn = require 'packer.util'.float,
    }
}}
