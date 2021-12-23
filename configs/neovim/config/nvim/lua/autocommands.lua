
-- config
vim.cmd([[
augroup reloading
    autocmd!
    autocmd BufWritePost autocommands.lua source <afile>
    autocmd BufWritePost lsp.lua source <afile>
    autocmd BufWritePost mappings.lua source <afile>
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    autocmd BufWritePost settings.lua source <afile>
    autocmd BufWritePost treesitter.lua source <afile>
augroup END
]])

-- location reloading
vim.cmd([[
augroup location
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
augroup END
]])

-- filetype detection
vim.cmd([[
augroup extra_filetypedetect
    autocmd!
    autocmd BufNewFile,BufRead *.cabal set filetype=cabal
    autocmd BufNewFile,BufRead *.cry set filetype=cryptol
    autocmd BufNewFile,BufRead *.hsc set filetype=haskell
    autocmd BufNewFile,BufRead *.idr set filetype=idris
    autocmd BufNewFile,BufRead *.{ll,lll,llo} set filetype=llvm
    autocmd BufNewFile,BufRead *.ott set filetype=ott
    autocmd BufNewFile,BufRead *.tex set filetype=tex
augroup END
]])

return nil
