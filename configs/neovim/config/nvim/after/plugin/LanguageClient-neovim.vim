
let g:LanguageClient_serverCommands = {
            \ 'rust': ['rust-analyzer'],
            \ }

if filereadable("./compile_commands.json")
  let clangd = glob('bazel-*/external/llvm_toolchain*/bin/clangd', 0, 1)
  if len(clangd) == 1
    let g:LanguageClient_serverCommands.cpp = [clangd[0]]
  else
    let g:LanguageClient_serverCommands.cpp = ['clangd']
  endif
endif

if filereadable("scripts/bin/typecheck")
  let g:LanguageClient_serverCommands.ruby = ['pay', 'exec', 'scripts/bin/typecheck', '--lsp']
elseif filereadable("~/stripe/sorbet/bazel-bin/main/sorbet")
  let g:LanguageClient_serverCommands.ruby = ['~/stripe/sorbet/bazel-bin/main/sorbet', '--lsp']
end

let g:LanguageClient_useVirtualText = "No"
let g:LanguageClient_hoverPreview = "Always"
let g:LanguageClient_selectionUI = "location-list"

nnoremap <silent> K  :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <LocalLeader>k  :call LanguageClient#explainErrorAtPoint()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <LocalLeader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <silent> <LocalLeader>a :call LanguageClient#textDocument_codeAction()<CR>
