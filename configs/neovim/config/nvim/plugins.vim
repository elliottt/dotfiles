
" {{{ vim-plug Setup
set nocompatible

" Setup plugins
filetype off

set rtp+=$VIMHOME/bundle/vim-plug
call plug#begin($VIMHOME . '/bundle')
" }}}

Plug 'lervag/wiki.vim'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'
let g:wiki_root = '~/.notes/'
let g:wiki_link_target_type = 'md'
let g:wiki_list_todos = ['[ ]', '[x]']
let g:wiki_journal = {
            \ 'name': 'journal',
            \ 'frequency': 'weekly',
            \ 'date_format': {
            \   'daily' : '%Y-%m-%d',
            \   'weekly' : '%Y_w%V',
            \   'monthly' : '%Y_m%m',
            \ },
            \ }
let g:wiki_mappings_use_defaults = 'global'
let g:wiki_mappings_local = {
            \ '<plug>(wiki-page-toc)': '<Leader>wt',
            \ '<plug>(wiki-link-open)': '<cr>',
            \ '<plug>(wiki-list-toggle)': '<c-s>',
            \ '<plug>(wiki-journal-next)': '<c-j>',
            \ '<plug>(wiki-journal-prev)': '<c-k>',
            \ }

if executable('gdate')
    let g:wiki_date_exe = 'gdate'
end


" two-trucs {{{
Plug 'elliottt/two-trucs', { 'do': 'make release' }
" }}}

" LanguageClient-neovom {{{
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }
" }}}

" fzf {{{
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" }}}

" {{{ Color Themes
Plug 'junegunn/seoul256.vim'
" }}}

" {{{ Haskell
Plug 'elliottt/vim-haskell'
" }}}

" {{{ Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

if $OS != 'windows'
    " no fancy symbols on windows
    let g:airline_powerline_fonts = 1
endif
" }}}

" {{{ Text alignment
Plug 'tommcdo/vim-lion'
" }}}

" {{{ Tmux integration
Plug 'benmills/vimux'
" }}}

" {{{ tpope plugins
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
" }}}

" {{{ Sayonara
Plug 'mhinz/vim-sayonara'
" }}}

" {{{ Markdown
Plug 'nelstrom/vim-markdown-folding'
let g:markdown_fold_style = 'nested'
" }}}

" {{{ Editing
Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
Plug 'jez/vim-superman'
" }}}

" {{{ Initialize plugins
call plug#end()
filetype on
" }}}
