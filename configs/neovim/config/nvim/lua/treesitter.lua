
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "c", "cpp", "lua", "ruby", "rust", "javascript" },
    highlight = {
        enable = true,
    },
}

return nil
