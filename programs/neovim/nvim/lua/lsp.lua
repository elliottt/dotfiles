
local lsp = require 'lspconfig'

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
    }
)

local util = require 'lspconfig.util'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- clangd config
if vim.fn.executable('clangd') == 1 then
    lsp.clangd.setup {
        capabilities = capabilities,
    }
end

-- go config
if vim.fn.glob("bin/gopls.sh") ~= "" then
    lsp.gopls.setup {
        cmd = { "bin/gopls.sh" },
    }
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
    sorbet_opts.root_dir = util.root_pattern(".git")
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
lsp.sorbet.setup(sorbet_opts)

-- rust-analyzer config
lsp.rust_analyzer.setup {
    capabilities = capabilities,
}

-- typescript config
if vim.fn.executable("typescript-language-server") == 1 then
    lsp.tsserver.setup {}
end
