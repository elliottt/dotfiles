-- vim: foldmethod=marker

require 'fzf-lua'.setup{
    defaults = {
        jump_to_single_result = true,
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

require 'dressing'.setup{
    select = {
        backend = { 'telescope', 'builtin' },
    }
}
