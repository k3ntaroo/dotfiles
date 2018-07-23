" ~/.config/nvim/init.vim

" dein.vim preferences
" {{{
let s:nvim_rc_path = $XDG_CONFIG_HOME . '/nvim/rc'
let g:rc_dir = expand(s:nvim_rc_path)

let s:dein_dir = expand($XDG_CONFIG_HOME . '/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml_file = g:rc_dir . '/dein.toml'
    call dein#load_toml(s:toml_file, {'lazy': 0})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
" }}}

" basis

filetype plugin indent on

set ruler
set autoindent
set number
set nowrap
set hidden
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ambiwidth=double
set foldmethod=marker
set backspace=start,indent,eol

" general
set wildignore+=*.DS_Store,*.exe,*.o,*.out,*.pdf,*.swp
" latex
set wildignore+=*.aux,*.dvi,*.toc,*.synctex,*.gz
" ocaml
set wildignore+=*.cm?,*.annot
" haskell
set wildignore+=*.hi

"-----------------------------------------------------------
" colorscheme
"-----------------------------------------------------------

syntax on
set background=light

colorscheme pencil

" colorscheme hybrid
" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1

highlight ExtraWhitespace ctermbg=cyan
match ExtraWhitespace /\s\+$/

"-----------------------------------------------------------
" netrw
"-----------------------------------------------------------

let g:netrw_liststyle=3
let g:netrw_banner=0 " disable the directory banner
let g:netrw_bufsettings='noma nomod number nobl nowrap ro'
let g:netrw_list_hide = '\.DS_Store$,.*\.swp$,.*\.o$,'
" latex
let g:netrw_list_hide .= '.*\.aux$,.*\.dvi$,.*\.toc$,.*\.synctex\.gz$,'
" ocaml
let g:netrw_list_hide .= '.*\.cm[aiox]$,.*\.annot$,'
" haskell
let g:netrw_list_hide .= '.*\.hi$,'

"-----------------------------------------------------------
" lightline
"-----------------------------------------------------------

let g:lightline = {
  \ 'colorscheme': 'PaperColor_light',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
  \ },
  \ }

"-----------------------------------------------------------
" nerdtree
"-----------------------------------------------------------

let NERDTreeIgnore = [
      \ '\.o',
      \ '\.cm[aiox]$',
      \ ]

"-----------------------------------------------------------
" key bindings
"-----------------------------------------------------------

nnoremap zq :<C-u>q<CR>
nnoremap <CR> :<C-u>w<CR>
nnoremap <C-z> <Nop>
nnoremap g[ :<C-u>tabprevious<CR>
nnoremap g] :<C-u>tabnext<CR>
nnoremap g- :<C-u>tabm -1<CR>
nnoremap g= :<C-u>tabm +1<CR>
nnoremap <Esc> :nohl<CR>

nnoremap <Leader>x :<C-u>NERDTreeToggle<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>D :bd<CR>
nnoremap <Leader>T :<C-u>tabnew<CR>
nnoremap <Leader>r :source $MYVIMRC<CR>
nnoremap <Space>b :ls<CR>
