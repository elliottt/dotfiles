-- vim: foldmethod=marker

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

local telescope = require 'telescope'

telescope.setup{
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
telescope.load_extension('fzf')

require 'which-key'.setup()

require 'Comment'.setup()

require 'leap'.setup{}

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
