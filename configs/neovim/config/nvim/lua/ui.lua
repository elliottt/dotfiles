local tabline = require 'tabline'
local lualine = require 'lualine'

-- NOTE: it's important to set the colorscheme before setting up tabline/lualine, as they seem to
-- cache color information from whatever theme is loaded when they load.

-- colors
vim.o.termguicolors = true
vim.cmd [[
    let g:sonokai_transparent_background = 1
    let g:sonokai_style = 'atlantis'
    colorscheme sonokai
]]

-- tabline
-- vim.g.tabline_show_devicons = false
tabline.setup { enable = false }

-- statusline
lualine.setup {
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
