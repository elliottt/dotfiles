
local wk = require 'which-key'

local function augroup(name, body)
    vim.api.nvim_create_augroup(name, { clear = true })

    local au = function(event, opts)
        opts = opts or {}
        opts.group = name
        vim.api.nvim_create_autocmd(event, opts)
    end

    body(au)
end

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

    au({"BufNewFile", "BufRead"}, {
        pattern = "*.isle",
        command = "set filetype=lisp et",
    })

    au({"BufNewFile", "BufRead"}, {
        pattern = "*.md",
        callback = function()
            wk.register({
                ["<localleader>f"] = { "<cmd>TTSort<cr>", "Format" },
                ["<localleader>n"] = { "<cmd>TTNext<cr>", "New TODO group" },
            }, {
                mode = "n",
                buffer = vim.api.nvim_get_current_buf(),
                noremap = true,
            })
        end,
    })
end)

return nil
