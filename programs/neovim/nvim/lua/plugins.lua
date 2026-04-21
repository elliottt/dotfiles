-- vim: foldmethod=marker

local actions = require 'fzf-lua'.actions

require 'fzf-lua'.setup{
    defaults = {
        lsp = {
            jump1 = true,
        },
        actions = {
            ["enter"] = actions.file_edit,
        },
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

require 'nvim-treesitter'.setup{}

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

require 'lualine'.setup {
    options = {
        icons_enabled = false,
        theme = 'seoul256',
    },
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype', 'lsp_status'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    }
}

require 'conform'.setup{
    format_on_save = nil,
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters = {
        rubyfmt_local = {
            command = vim.fs.abspath("~/stripe/rubyfmt/target/release/rubyfmt-main"),
        },
    },
    formatters_by_ft = {
        ruby = { "rubyfmt_local" },
    },
}

return nil
