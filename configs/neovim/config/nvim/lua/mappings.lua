
vim.g.mapleader = vim.api.nvim_replace_termcodes('<Space>', false, false, true)
vim.g.maplocalleader = vim.api.nvim_replace_termcodes('<BS>', false, false, true)

local wk = require 'which-key'

wk.register({
    ['jk'] = { '<esc>', 'Escape shortcut' },
}, { mode = 'i' })

wk.register{
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

    -- leap
    ['s'] = { '<Plug>(leap-forward)', 'Leap forward' },
    ['S'] = { '<Plug>(leap-backward)', 'Leap backward' },
}

-- vsnip mappings
local vsnip_keymaps = {
    ['<c-j>'] = { [[vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<c-j>']], "Expand snippet" },
    ['<tab>'] = { [[vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>']] },
    ['<S-Tab>'] = { [[vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']] },
}
wk.register(vsnip_keymaps, {
    mode = 'i',
    noremap = true,
    expr = true,
    silent = true,
})
wk.register(vsnip_keymaps, {
    mode = 's',
    noremap = true,
    expr = true,
    silent = true,
})

-- nvim-cmp mappings
local cmp = require 'cmp'
cmp.setup{
    completion = {
        -- only trigger completion when c-f is pressed
        autocomplete = false,
    },

    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end
    },

    mapping = {
        ['<c-f>'] = cmp.mapping(cmp.mapping.complete(), { 'i' }),
        ['<cr>'] = cmp.mapping.confirm{ select = true },
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item{ behavior = cmp.SelectBehavior.Select }, {'i'}),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item{ behavior = cmp.SelectBehavior.Select }, {'i'}),
    },

    sources = cmp.config.sources{
        { name = 'nvim_lsp' },
    },
}

-- lsp
local function lsp_attach(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    wk.register({
        ['<localleader>f'] = { '<cmd>lua LspUtil.format()<cr>', 'Format' },
        ['<localleader>a'] = { '<cmd>lua LspUtil.code_action()<cr>', 'Code actions' },
        ['<localleader>rn'] = { '<cmd>lua LspUtil.rename()<cr>', 'Rename' },
        ['<localleader>k'] = { '<cmd>lua LspUtil.diagnostic.open()<cr>', 'Line diagnostics' },
        ['<localleader>q'] = { '<cmd>lua LspUtil.diagnostic.quickfix()<cr>', 'Diagnostics' },
        ['K'] = { '<cmd>lua LspUtil.hover()<cr>', 'Hover' },
        ['gd'] = { '<cmd>lua LspUtil.definition()<cr>', 'Go to definition' },
        ['gD'] = { '<cmd>lua LspUtil.declaration()<cr>', 'Go to declaration' },
        ['gi'] = { '<cmd>lua LspUtil.implementation()<cr>', 'Go to implementation' },
        ['gr'] = { '<cmd>lua LspUtil.references()<cr>', 'Find all references' },
        ['[d'] = { '<cmd>lua LspUtil.diagnostic.prev()<cr>', 'Previous diagnostic' },
        [']d'] = { '<cmd>lua LspUtil.diagnostic.next()<cr>', 'Next diagnostic' },
    }, {
        buffer = bufnr,
        mode = 'n',
        silent = true,
    })
end

return { lsp_attach = lsp_attach }
