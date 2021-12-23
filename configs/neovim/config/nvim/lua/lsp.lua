
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

require 'lspsaga'.init_lsp_saga {
    border_style = "round",
}

local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

return {
    setup = function(mappings)
        local home = vim.fn.environ().HOME

        -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
        local sumneko_root_path = vim.fn.environ().HOME .. '/Source/lua-language-server'
        if vim.fn.isdirectory(sumneko_root_path) ~= 0 then
            local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            lsp.sumneko_lua.setup {
              on_attach = mappings.lsp_attach,
              cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = runtime_path,
                  },
                  diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                  },
                  workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                  },
                  -- Do not send telemetry data containing a randomized but unique identifier
                  telemetry = {
                    enable = false,
                  },
                },
              },
            }
        end

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

        -- sorbet config
        local sorbet_opts = {
            on_attach = mappings.lsp_attach,
            capabilities = capabilities,
        }

        if vim.fn.glob("scripts/bin/typecheck") ~= "" then
            -- use 'pay exec' when in pay-server
            sorbet_opts.cmd = { "pay", "exec", "scripts/bin/typecheck", "--lsp" }
        else
            local local_sorbet_build = vim.fn.glob(home.."/stripe/sorbet/bazel-bin/main/sorbet")
            if local_sorbet_build ~= "" then
                -- prefer a local build of sorbet if it's available
                sorbet_opts.cmd = { local_sorbet_build, "--lsp", "--silence-dev-message" }
            end
        end
        lsp.sorbet.setup(sorbet_opts)

        -- rust-analyzer config
        lsp.rust_analyzer.setup {
            on_attach = mappings.lsp_attach,
            capabilities = capabilities,
        }

    end
}
