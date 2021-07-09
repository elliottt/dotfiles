
-- config
vim.cmd([[
augroup config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    autocmd BufWritePost autocommands.lua source <afile>
    autocmd BufWritePost mappings.lua source <afile>
    autocmd BufWritePost settings.lua source <afile>
    autocmd BufWritePost lsp.lua source <afile>
augroup END
]])

-- location reloading
vim.cmd([[
augroup location
    autocmd!

    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
augroup END
]])

-- lua
function init_lua()
    print("lua!")
    vim.bo.textwidth = 100
end

vim.cmd([[
augroup lua
    autocmd!
    autocmd BufReadPost *.lua :lua init_lua()
augroup END
]])

return nil
