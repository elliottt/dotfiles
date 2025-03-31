-- vim: foldmethod=marker

require 'fzf-lua'.setup{
    defaults = {
        jump1 = true,
        winopts = {
            preview = {
                default = 'bat',
                layout = 'vertical',
            }
        },
    }
}

require 'which-key'.setup()

require 'Comment'.setup()

require 'leap'.setup{}

require 'nvim-surround'.setup{}

require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
}

-- Temporary workaround for flickering when the same buffer is viewed from
-- different positions: https://github.com/neovim/neovim/issues/32660#issuecomment-2693494954
-- should be fixed by https://github.com/neovim/neovim/pull/33145
vim.g._ts_force_sync_parsing = true

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

local tabline = require 'tabline'

tabline.setup { enable = false }

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
require 'mkdnflow'.setup {
    to_do = {
        symbols = { ' ', '-', 'x' }
    },
    modules = {
        folds = false,
    },
    links = {
        conceal = true,
    },
    mappings = {
        MkdnGoBack = false,
    },
}
