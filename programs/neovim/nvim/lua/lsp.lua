
-- The log fills up way too quickly, and this is easy to locally turn back on if
-- necessary.
vim.lsp.set_log_level('OFF')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
    }
)

local capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- clangd config
vim.lsp.config('clangd', {
    capabilities = capabilities,
})
vim.lsp.enable('clangd')

-- go config
if vim.fn.glob("bin/gopls.sh") ~= "" then
    vim.lsp.config('gopls', {
        cmd = { "bin/gopls.sh" },
    })
    vim.lsp.enable('gopls')
end

-- sorbet config
local sorbet_opts = {
    capabilities = capabilities,
}

if vim.fn.glob("scripts/bin/typecheck") ~= "" then
    -- use 'pay exec' when in pay-server
    sorbet_opts.cmd = {
        "scripts/dev_productivity/while_pay_up_connected.sh",
        "pay",
        "exec",
        "scripts/bin/typecheck",
        "--lsp",
        "--enable-all-experimental-lsp-features",
    }
    sorbet_opts.root_dir = nil
    sorbet_opts.root_markers = {'.git'}
else
    local home = vim.fn.environ().HOME
    local local_sorbet_build = vim.fn.glob(home.."/stripe/sorbet/bazel-bin/main/sorbet")
    if local_sorbet_build ~= "" then
        -- prefer a local build of sorbet if it's available
        sorbet_opts.cmd = {
            local_sorbet_build,
            "--silence-dev-message",
            "--lsp",
            "--enable-all-experimental-lsp-features",
            ".",
        }
    end
end

vim.lsp.config('sorbet', sorbet_opts)
vim.lsp.enable('sorbet')

-- rust-analyzer config
vim.lsp.config('rust-analyzer', {
    capabilities = capabilities,
})
vim.lsp.enable('rust-analyzer')
