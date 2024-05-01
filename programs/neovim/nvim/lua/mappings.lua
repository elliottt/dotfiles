
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
    -- Count buffers that are both loaded and listed. This excludes both hidden buffers, and the
    -- default buffer from the total count, making a result of `0` indicate that there are no useful
    -- buffers open.
    local listed_buffers = 0
    for i=1,vim.fn.bufnr('$') do
        local info = vim.fn.getbufinfo(i)[1]
        if info ~= nil and info.listed == 1 then
            if info.name ~= "" or info.changed ~= 0 then
                listed_buffers = listed_buffers + 1
            end
        end
    end

    -- As a shortcut, if this is an unlisted buffer, and there are splits present, close the split
    -- immediately. This handles help splits and the like by closing those splits, instead of
    -- assuming that they should stick around.
    local bufname = vim.fn.bufname('%')
    local num_splits = vim.fn.tabpagewinnr(vim.fn.tabpagenr(), '$')
    if vim.fn.buflisted(bufname) == 0 and num_splits > 1 then
        vim.cmd('close')
        return
    end

    -- Close buffers but preserve splits.
    if listed_buffers > 1 then
        vim.cmd('bprevious')

        -- As changing away from the buffer could have already deleted it (like with fugitive) only
        -- delete if it's still present, and close the split if the buffer disappears.
        if vim.fn.buflisted(bufname) == 1 then
            vim.cmd('bdelete #')
        elseif num_splits > 1 then
            vim.cmd('close')
        end

        return
    end

    -- Close if there are more than one split open.
    if num_splits > 1 then
        vim.cmd('close')
        return
    end

    -- If there's still a buffer left, delete it.
    if listed_buffers > 0 then
        vim.cmd('bdelete')
        return
    end

    -- Finally, if all else fails, quit
    vim.cmd('quit')
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

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

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

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn['vsnip#available'](1) == 1 then
                feedkey('<Plug>(vsnip-expand-or-jump)', '')
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                feedkey('<Plug>(vsnip-jump-prev)', '')
            else
                fallback()
            end
        end, { 'i', 's' }),
    },

    sources = cmp.config.sources{
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
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
