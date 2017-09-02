" ~/.config/nvim/init.vim

set ruler
set autoindent
set nohlsearch
set number
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set hidden

set backspace=start,indent,eol

filetype plugin indent on

" BEGIN dein.vim preferences
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
" END dein.vim preferences

syntax on
set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid

" netrw
nn <space>x :<C-u>Explore<CR>
let g:netrw_liststyle=3
let g:netrw_banner=0 " disable the directory banner
let g:netrw_bufsettings='noma nomod number nobl nowrap ro'
let g:netrw_list_hide='.DS_Store$,.*\.aux$,.*\.dvi$,.*\.fdb_latexmk,.*\.fls$,.*\.synctex\.gz$,.*\.swp$,.*\.toc$'

nn <CR> :<C-u>w<CR>
nn g[ :<C-u>tabprevious<CR>
nn g] :<C-u>tabnext<CR>
nn g- :<C-u>tabm -1<CR>
nn g= :<C-u>tabm +1<CR>

nn <space>t :<C-u>tabnew<CR>
nn <space>T :<C-u>tabnew<CR>:<C-u>Explore<CR>
nn <space>d :<C-u>b#\|bd #<CR>
nn <space>r :source $HOME/.config/nvim/init.vim<CR>
nn <C-z> <Nop>
