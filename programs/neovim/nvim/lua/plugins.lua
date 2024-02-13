-- vim: foldmethod=marker

-- Bootstrap packer
local fn = vim.fn

local install_path = fn.stdpath("data") .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd.packadd('packer.nvim')
end

return require 'packer'.startup{function(use)

    use 'wbthomason/packer.nvim'

    -- Utility plugins
    use {
        'elliottt/two-trucs',
        run = 'make release'
    }

    use 'elliottt/wit.nvim'

    use {
        'junegunn/fzf',
        run = './install --bin'
    }
    use 'junegunn/fzf.vim'

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = "make",
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
        branch = '0.1.x',
        config = function()
            -- When multi-selection is present use `:e` on all of them, otherwise fall back to
            -- `select_default`.
            -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1679797700
            local select_one_or_multi = function(prompt_bufnr)
                print('one or multi')
                local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                print('picker')
                local multi = picker:get_multi_selection()
                print('multi')
                if not vim.tbl_isempty(multi) then
                    print('testing')
                    require('telescope.actions').close(prompt_bufnr)
                    for _, j in pairs(multi) do
                        if j.path ~= nil then
                            vim.cmd('edit ' .. j.path)
                        end
                    end
                else
                    print('single')
                    require('telescope.actions').select_default(prompt_bufnr)
                end
            end

            require 'telescope'.setup{
                defaults = {
                    layout_strategy = 'vertical',
                    mappings = {
                        i = {
                            ['<CR>'] = select_one_or_multi,
                            ['<C-J>'] = 'move_selection_next',
                            ['<C-K>'] = 'move_selection_previous',
                        },
                        n = {
                            ['<CR>'] = select_one_or_multi,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            }
            require 'telescope'.load_extension('fzf')
        end,
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
            require 'Comment'.setup()
        end,
    }

    use {
        'ggandor/leap.nvim',
        config = function()
            require 'leap'.setup{}
        end,
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "javascript",
                    "lua",
                    -- "ruby",
                    "rust",
                    "typescript",
                    "vim",
                },
                highlight = {
                    enable = true,
                },
            }
        end,
    }

    -- LSP
    use 'neovim/nvim-lspconfig'

    -- Completion
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Colorschemes
    use {
        'rebelot/kanagawa.nvim',
        disable = false,
        config = function()
            require 'kanagawa'.setup{
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = 'none',
                            },
                        },
                    },
                },
                transparent = true,
            }
            vim.cmd.colorscheme('kanagawa')
        end
    }

    use {
        'sainnhe/sonokai',
        disable = true,
        config = function()
            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_style = 'atlantis'
            vim.cmd.colorscheme('sonokai')
        end,
    }

    -- Statuslines
    use 'kyazdani42/nvim-web-devicons'

    use {
        'kdheepak/tabline.nvim',
        requires = {{'kyazdani42/nvim-web-devicons', opt = true }},
        after = {'sonokai', 'kanagawa.nvim'},
        config = function()
            require 'tabline'.setup { enable = false }
        end,
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {{ 'kyazdani42/nvim-web-devicons', opt = true }},
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

    use {
        'jakewvincent/mkdnflow.nvim',
        config = function()
            require 'mkdnflow'.setup {
                to_do = {
                    symbols = { ' ', '-', 'x' }
                },
                modules = {
                    maps = true,
                },
                mappings = {
                    MkdnFoldSection = false,
                    MkdnUnfoldSection = false,
                },
            }
        end,
    }

    use {
        'stevearc/dressing.nvim',
        config = function()
            require 'dressing'.setup{
                select = {
                    backend = { 'telescope', 'builtin' },
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
