" ~/.config/nvim/init.vim

set ruler
set autoindent
set number
set nowrap
set nohlsearch
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set hidden
set ambiwidth=double

set backspace=start,indent,eol

filetype plugin indent on

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

syntax on
set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid

" netrw
nnoremap <leader>x :<C-u>Explore<CR>
nnoremap <leader>q :q<CR>
let g:netrw_liststyle=3
let g:netrw_banner=0 " disable the directory banner
let g:netrw_bufsettings='noma nomod number nobl nowrap ro'
let g:netrw_list_hide='.DS_Store$,.*\.aux$,.*\.dvi$,.*\.fdb_latexmk,.*\.fls$,.*\.synctex\.gz$,.*\.swp$,.*\.toc$'

nnoremap <CR> :<C-u>w<CR>
nnoremap g[ :<C-u>tabprevious<CR>
nnoremap g] :<C-u>tabnext<CR>
nnoremap g- :<C-u>tabm -1<CR>
nnoremap g= :<C-u>tabm +1<CR>

nnoremap <leader>t :<C-u>tabnew<CR>
nnoremap <leader>T :<C-u>tabnew<CR>:<C-u>Explore<CR>
nnoremap <leader>d :<C-u>b#\|bd #<CR>
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <C-z> <Nop>
