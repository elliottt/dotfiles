-- vim: foldmethod=marker

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

return require 'lazy'.setup({

    -- Utility plugins
    {
        'elliottt/two-trucs',
        build = 'make release'
    },

    'elliottt/wit.nvim',

    {
        'junegunn/fzf',
        build = './install --bin'
    },

    'junegunn/fzf.vim',

    'nvim-lua/plenary.nvim',

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },

    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
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
    },

    'tpope/vim-repeat',
    'tpope/vim-fugitive',
    'tpope/vim-surround',

    {
        'folke/which-key.nvim',
        config = function()
            require 'which-key'.setup()
        end
    },

    {
        'numToStr/Comment.nvim',
        config = function()
            require 'Comment'.setup()
        end,
    },

    {
        'ggandor/leap.nvim',
        config = function()
            require 'leap'.setup{}
        end,
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            vim.cmd(":TSUpdate")
        end,
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
    },

    -- LSP
    'neovim/nvim-lspconfig',

    -- Completion
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',

    -- Colorschemes
    {
        'rebelot/kanagawa.nvim',
        enabled = true,
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
    },

    {
        'sainnhe/sonokai',
        enabled = false,
        config = function()
            vim.g.sonokai_transparent_background = 1
            vim.g.sonokai_style = 'atlantis'
            vim.cmd.colorscheme('sonokai')
        end,
    },

    -- Statuslines
    'nvim-tree/nvim-web-devicons',

    {
        'kdheepak/tabline.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require 'tabline'.setup { enable = false }
        end,
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
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
    },

    {
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
    },

    {
        'stevearc/dressing.nvim',
        config = function()
            require 'dressing'.setup{
                select = {
                    backend = { 'telescope', 'builtin' },
                }
            }
        end,
    },
}, {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
