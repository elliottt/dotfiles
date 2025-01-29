
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

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})

-- Wrapper functions to centralize lsp visual config.
LspUtil = {
    format = function()
        return vim.lsp.buf.format()
    end,

    code_action = function()
        return vim.lsp.buf.code_action()
    end,

    rename = function()
        return vim.lsp.buf.rename()
    end,

    hover = function()
        return vim.lsp.buf.hover()
    end,

    definition = function()
        return vim.lsp.buf.definition()
    end,

    declaration = function()
        return vim.lsp.buf.declaration()
    end,

    implementation = function()
        return vim.lsp.buf.implementation()
    end,

    references = function()
        return vim.lsp.buf.references()
    end,

    diagnostic = {
        open = function()
            return vim.diagnostic.open_float{
                border = 'rounded',
            }
        end,

        quickfix = function()
            return vim.diagnostic.setloclist()
        end,

        next = function()
            return vim.diagnostic.goto_next{
                float = {
                    border = 'rounded',
                },
            }
        end,

        prev = function()
            return vim.diagnostic.goto_prev{
                float = {
                    border = 'rounded',
                },
            }
        end,
    },
}

local util = require 'lspconfig.util'
local capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())

return {
    setup = function(mappings)
        local home = vim.fn.environ().HOME

        -- clangd config
        local clangd_path = vim.fn.glob('bazel-*/external/llvm_toolchain*/bin/clangd')
        if clangd_path ~= "" then
            lsp.clangd.setup {
                on_attach = mappings.lsp_attach,
                cmd = { clangd_path, "--background-index" },
                capabilities = capabilities,
            }
        elseif vim.fn.executable('clangd') == 1 then
            lsp.clangd.setup {
                on_attach = mappings.lsp_attach,
                capabilities = capabilities,
            }
        end

        if vim.fn.glob("bin/gopls.sh") ~= "" then
            lsp.gopls.setup {
                cmd = { "bin/gopls.sh" },
                on_attach = mappings.lsp_attach,
            }
        end

        -- sorbet config
        local sorbet_opts = {
            on_attach = mappings.lsp_attach,
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
            on_attach = mappings.lsp_attach,
            capabilities = capabilities,
        }

        -- typescript config
        if vim.fn.executable("typescript-language-server") == 1 then
            lsp.tsserver.setup {
                on_attach = mappings.lsp_attach,
            }
        end

    end
}
