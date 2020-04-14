
" install plugins
call plug#begin('~/.vim/plug-plug')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'micha/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
"Plug 'valloric/youcompleteme', { 'do': './install.py --clang-completer' }
"Plug 'vim-latex/vim-latex'
"Plug 'JuliaEditorSupport/julia-vim'
"Plug 'tomtom/tlib_vim'
"Plug 'marcweber/vim-addon-mw-utils'
"Plug 'garbas/vim-snipmate'
"Plug 'honza/vim-snippets'
"Plug 'ervandew/supertab'
"Plug 'xavierd/clang_complete'
"Plug 'vim-syntastic/syntastic'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

syntax on
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
set nu
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set colorcolumn=80
set hlsearch

" Disable arrow keys in normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set undofile                                                                       
set undodir=~/.vim/vim-undo
set ruler
set nocp
set tw=80
let g:clang_library_path='/usr/lib/llvm-3.8/lib'
"set foldmethod=indent
"set foldlevel=1
"set foldclose=all
au BufRead,BufNewFile *.txx setfiletype cpp 
au BufRead,BufNewFile *.tpp setfiletype cpp 
let g:plug_timeout=90000
let g:vim_markdown_folding_disabled = 1


"Spell check
set spell spelllang=en_us

let g:org_agenda_files = ['~/org/*.org']

set foldmethod=syntax
set nofoldenable
nnoremap <space> za
autocmd BufNewFile,BufRead *.tpp   set syntax=cpp
autocmd BufNewFile,BufRead *.txx   set syntax=cpp

" from https://stackoverflow.com/questions/2372307/opening-files-in-vim-using-fuzzy-search
set runtimepath^=~/.vim/bundle/ctrlp.vim
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" CtrlP options
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0
let g:tex_flavor = "latex"

"airline related
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline_extensions = ['ctrlp','tabline']
