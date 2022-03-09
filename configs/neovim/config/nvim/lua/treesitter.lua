
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "c", "cpp", "javascript", "lua", "ruby", "rust", "typescript" },
    highlight = {
        enable = true,
    },
}

return nil
