
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('i', 'jk', '<esc>', opts)

local wk = require 'which-key'

wk.register({
    ['jk'] = { '<esc>', 'Escape shortcut' },
}, {
    mode = 'i',
    silent = true,
})

wk.register({
    -- fzf
    ['<leader>b'] = { '<cmd>Buffers<cr>', 'Buffers' },
    ['<leader>f'] = { '<cmd>Files<cr>', 'Files' },
    ['<leader>t'] = { '<cmd>Tags<cr>', 'Tags' },

    -- git
    ['<leader>g'] = { '<cmd>Git<cr>', 'Git' },

    -- text operations
    ['<leader>U'] = { 'gUaw', 'Uppercase word' },
    ['<leader>u'] = { 'guaw', 'Lowercase word' },

    -- misc
    ['<leader>h'] = { '<cmd>noh<cr>', 'Clear highlighting' },
    ['<leader>p'] = { '<cmd>set nolist! paste! number!<cr>', 'Toggle paste mode' },

    -- buffer management
    ['<c-n>'] = { '<cmd>bnext<cr>', 'Next buffer' },
    ['<c-p>'] = { '<cmd>bprevious<cr>', 'Previous buffer' },
    ['<c-d>'] = { '<cmd>Sayonara<cr>', 'Close buffer' },

    -- list navigation
    ['[q'] = { '<cmd>cprev<cr>', 'Previous quickfix item' },
    [']q'] = { '<cmd>cnext<cr>', 'Next quickfix item' },
    ['[l'] = { '<cmd>lprev<cr>', 'Previous location item' },
    [']l'] = { '<cmd>lnext<cr>', 'Next location item' },
}, {
    mode = 'n',
    silent = true,
})

-- stop entering ex mode
vim.api.nvim_set_keymap('n', 'Q', '<nop>', opts)

-- lsp
local function lsp_attach(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    wk.register({
        ['<localleader>f'] = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
        ['<localleader>a'] = { '<cmd>lua require "lspsaga.codeaction".code_action()<cr>', 'Code actions' },
        ['<localleader>rn'] = { '<cmd>lua require "lspsaga.rename".rename()<cr>', 'Rename' },
        ['<localleader>k'] = { '<cmd>lua require "lspsaga.diagnostic".show_line_diagnostics()<cr>', 'Line diagnostics' },
        ['<localleader>q'] = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'Diagnostics' },
        ['K'] = { '<cmd>lua require "lspsaga.hover".render_hover_doc()<cr>', 'Hover' },
        ['gs'] = { '<cmd>lua require "lspsaga.signaturehelp".signature_help()<cr>', 'Signature help' },
        ['gd'] = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to definition' },
        ['gD'] = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to declaration' },
        ['gi'] = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Go to implementation' },
        ['gr'] = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Find all references' },
        ['[d'] = { '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', 'Previous diagnostic' },
        [']d'] = { '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', 'Next diagnostic' },
    }, {
        buffer = bufnr,
        mode = 'n',
        silent = true,
    })
end

return { lsp_attach = lsp_attach }
