
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('i', 'jk', '<esc>', opts)

-- fzf
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Files<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>Tags<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Buffers<cr>', opts)

-- fugitive
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Git<cr>', opts)

-- clear highlighting
vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>noh<cr>', opts)

-- buffer navigation
vim.api.nvim_set_keymap('n', '<c-n>', '<cmd>bnext<cr>', opts)
vim.api.nvim_set_keymap('n', '<c-p>', '<cmd>bprevious<cr>', opts)

-- buffer closeing
vim.api.nvim_set_keymap('n', '<c-d>', '<cmd>Sayonara<cr>', opts)

-- toggle trailing space
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>set nolist! paste! number!<cr>', opts)

-- list navigation
vim.api.nvim_set_keymap('n', '[q', '<cmd>cprev<cr>', opts)
vim.api.nvim_set_keymap('n', ']q', '<cmd>cnext<cr>', opts)
vim.api.nvim_set_keymap('n', '[l', '<cmd>lprev<cr>', opts)
vim.api.nvim_set_keymap('n', ']l', '<cmd>lnext<cr>', opts)

-- stop entering ex mode
vim.api.nvim_set_keymap('n', 'Q', '<nop>', opts)

-- sort the visual selection
vim.api.nvim_set_keymap('v', '<leader>s', '<cmd>sort<cr>', opts)

-- case changing
vim.api.nvim_set_keymap('n', '<leader>U', 'gUaw', opts)
vim.api.nvim_set_keymap('n', '<leader>u', 'guaw', opts)

-- lsp
local function lsp_attach(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>a', '<cmd>lua vim.lsp.buf.codeaction()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>k', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
end

return { lsp_attach = lsp_attach }
