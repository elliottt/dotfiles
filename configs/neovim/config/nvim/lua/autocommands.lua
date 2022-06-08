
function augroup(name, body)
    vim.api.nvim_create_augroup(name, { clear = true })

    local au = function(event, opts)
        opts = opts or {}
        opts.group = name
        vim.api.nvim_create_autocmd(event, opts)
    end

    body(au)
end

-- config
augroup("reloading", function(au)
    au({"BufWritePost"}, {
        pattern = {
            "autocommands.lua",
            "lsp.lua",
            "mappings.lua",
            "plugins.lua",
            "settings.lua",
            "treesitter.lua",
        },
        command = "source <afile>",
    })

    au({"BufWritePost"}, {
        pattern = "plugins.lua",
        command = "source <afile> | PackerSync",
    })
end)

-- location reloading
augroup("location", function(au)
    au({"BufReadPost"}, {
        command = [[if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
    })
end)

-- filetype detection
augroup("extra_filetypedetect", function(au)
    local function filetype(pat, type)
        au({"BufNewFile", "BufRead"}, {
            pattern = pat,
            command = "set filetype=" .. type,
        })
    end
    filetype("*.cabal", "cabal")
    filetype("*.cry", "cryptol")
    filetype("*.hsc", "haskell")
    filetype("*.idr", "idris")
    filetype("*.{ll,lll,llo}", "llvm")
    filetype("*.ott", "ott")
    filetype("*.tex", "tex")
    filetype("*.isle", "lisp")
end)

return nil
