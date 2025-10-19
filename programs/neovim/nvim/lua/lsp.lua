
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

-- Enable completion globally
vim.lsp.config('*', {
    capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())
})

vim.lsp.enable({'clangd', 'rust_analyzer'})

-- sorbet config
if vim.fn.glob("scripts/bin/typecheck") ~= "" then
    vim.lsp.config('sorbet', {
        -- use 'pay exec' when in pay-server
        cmd = {
            "scripts/dev_productivity/while_pay_up_connected.sh",
            "pay",
            "exec",
            "scripts/bin/typecheck",
            "--lsp",
            "--enable-all-experimental-lsp-features",
        },
        root_markers = {'.git'}
    })
    vim.lsp.enable('sorbet')
else
    local home = vim.fn.environ().HOME
    local local_sorbet_build = vim.fn.glob(home.."/stripe/sorbet/bazel-bin/main/sorbet")
    if local_sorbet_build ~= "" then
        vim.lsp.config('sorbet', {
            -- prefer a local build of sorbet if it's available
            cmd = {
                local_sorbet_build,
                "--silence-dev-message",
                "--lsp",
                "--enable-all-experimental-lsp-features",
                ".",
            }
        })
        vim.lsp.enable('sorbet')
    end
end

-- go config
if vim.fn.glob("bin/gopls.sh") ~= "" then
    vim.lsp.config('gopls', {
        cmd = { "bin/gopls.sh" },
    })

    -- Don't univerally enable gopls
    vim.lsp.enable('gopls')
end
