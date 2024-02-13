
vim.g.mapleader = vim.api.nvim_replace_termcodes('<Space>', false, false, true)
vim.g.maplocalleader = vim.api.nvim_replace_termcodes('<BS>', false, false, true)

local wk = require 'which-key'

wk.register({
    ['jk'] = { '<esc>', 'Escape shortcut' },
}, { mode = 'i' })

local telescope = require 'telescope.builtin'

-- Toggle all the stuff needed to get into a reasonable mode for copy/paste from elsewhere. This
-- assumes that number and relativenumber are already on.
local function toggle_paste()
    vim.o.paste = not vim.o.paste
    vim.o.number = not vim.o.number
    vim.o.relativenumber = not vim.o.relativenumber
end

-- Close buffers, preserving split layout until there's a single buffer remaining.
local function close_buffer()
    -- as a shortcut, if this is an unlisted buffer, delete it immediately
    local bufname = vim.fn.bufname('%')
    if vim.fn.buflisted(bufname) == 0 then
        vim.cmd('bdelete')
        return
    end

    local listed_buffers = 0
    for i=1,vim.fn.bufnr('$') do
        if vim.fn.buflisted(i) == 1 then
            listed_buffers = listed_buffers + 1
        end
    end

    -- close buffers but preserve the split
    if listed_buffers > 1 then
        vim.cmd('bprevious')

        -- as changing away from the buffer could have already deleted it (like with fugitive) only
        -- delete if it's still present, and close the split if the buffer disappears.
        if vim.fn.buflisted(bufname) == 1 then
            vim.cmd('bdelete #')
        else
            vim.cmd('close')
        end

        return
    end

    -- count the number of open splits, and close the split if it's non-zero
    if vim.fn.tabpagewinnr(vim.fn.tabpagenr(), '$') > 1 then
        vim.cmd('close')
        return
    end

    -- if there's still a buffer left, delete it
    if listed_buffers > 0 then
        vim.cmd('bdelete')
    end
end

wk.register{
    -- fzf
    ['<leader>b'] = { '<cmd>Telescope buffers<cr>', 'Buffers' },
    ['<leader>f'] = { '<cmd>Telescope find_files<cr>', 'Files' },
    ['<leader>t'] = { '<cmd>Telescope tags<cr>', 'Tags' },

    -- git
    ['<leader>g'] = { '<cmd>Git<cr>', 'Git' },

    -- text operations
    ['<leader>U'] = { 'gUaw', 'Uppercase word' },
    ['<leader>u'] = { 'guaw', 'Lowercase word' },
    ['<leader>l'] = { telescope.live_grep, 'Live grep' },

    -- misc
    ['<leader>h'] = { '<cmd>noh<cr>', 'Clear highlighting' },
    ['<leader>p'] = { toggle_paste, 'Toggle paste mode' },

    -- buffer management
    ['<c-n>'] = { '<cmd>bnext<cr>', 'Next buffer' },
    ['<c-p>'] = { '<cmd>bprevious<cr>', 'Previous buffer' },
    ['<c-d>'] = { close_buffer, 'Close buffer' },

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
        ['<c-j>'] = cmp.mapping(cmp.mapping.select_next_item{ behavior = cmp.SelectBehavior.Select }, {'i'}),
        ['<c-k>'] = cmp.mapping(cmp.mapping.select_prev_item{ behavior = cmp.SelectBehavior.Select }, {'i'}),
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
        ['<localleader>d'] = { '<cmd>Telescope lsp_diagnostics<cr>', 'Diagnostics' },
        ['<localleader>s'] = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document symbols' },
        ['K'] = { '<cmd>lua LspUtil.hover()<cr>', 'Hover' },
        ['gd'] = { '<cmd>Telescope lsp_definitions<cr>', 'Go to definition' },
        ['gD'] = { '<cmd>Telescope lsp_type_definitions<cr>', 'Go to declaration' },
        ['gi'] = { '<cmd>Telescope lsp_implementations<cr>', 'Go to implementation' },
        ['gr'] = { '<cmd>Telescope lsp_references<cr>', 'Find all references' },
        ['[d'] = { '<cmd>lua LspUtil.diagnostic.prev()<cr>', 'Previous diagnostic' },
        [']d'] = { '<cmd>lua LspUtil.diagnostic.next()<cr>', 'Next diagnostic' },
    }, {
        buffer = bufnr,
        mode = 'n',
        silent = true,
    })
end

return { lsp_attach = lsp_attach }
