
" install plugins
call plug#begin('~/.vim/plug-plug')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
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
if exists('$VIM_DEV')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
Plug 'ervandew/supertab'
endif
call plug#end()

set nocompatible
set backspace=indent,eol,start "backspace over everything in insert mode

syntax on
set background=dark
"let g:solarized_termcolors=256
silent! colorscheme solarized
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
" Disable backspace in normal and insert mode
noremap <BS> <NOP>
inoremap <BS> <NOP>
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
"let g:plug_timeout=90000
let g:vim_markdown_folding_disabled = 1


"Spell check
set spell spelllang=en_us

let g:org_agenda_files = ['~/org/*.org']

set foldmethod=syntax
set nofoldenable
"nnoremap <space> za
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

" Disable that stupid bell
autocmd GUIEnter * set vb t_vb=
set vb t_vb=
set noerrorbells

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""             For coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('$VIM_DEV')
" Define coc plugins to install
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-clangd',
            \ 'coc-python',
            \ 'coc-snippets',
            \ 'coc-ultisnips',
            \ 'coc-texlab',
            \ ]


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"
"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
"" position. Coc only does snippet and additional edit on confirm.
" TODO uncomment once coc.nvim is properly installed...
"if exists('*complete_info')
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"else
"  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" coc-snippets
" Use <C-m> for trigger snippet expand.
"imap <C-m> <Plug>(coc-snippets-expand)

" Use <C-b> for select text for visual placeholder of snippet.
vmap <C-b> <Plug>(coc-snippets-select)

" Use <C-b> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-b>'

" Use <C-n> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-n>'

" Use <C-b> for both expand and jump (make expand higher priority.)
imap <C-b> <Plug>(coc-snippets-expand-jump)
endif
