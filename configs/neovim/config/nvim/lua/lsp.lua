
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

return {
    setup = function(mappings)
        -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
        local sumneko_root_path = vim.fn.environ().HOME .. '/Source/lua-language-server'
        local sumneko_binary = sumneko_root_path.."/bin/Linux/lua-language-server"

        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")

        lsp.sumneko_lua.setup {
          on_attach = mappings.lsp_attach,
          cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
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

        lsp.clangd.setup {
            on_attach = mappings.lsp_attach,
        }

        lsp.rust_analyzer.setup {
            on_attach = mappings.lsp_attach,
        }
    end
}
