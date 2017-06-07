" ~/.config/nvim/init.vim

set ruler
set autoindent
set nohlsearch

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

    let s:toml = g:rc_dir . '/dein.toml'
    call dein#load_toml(s:toml, {'lazy': 0})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
" END dein.vim preferences

" solarized
syntax enable
set background=light
colorscheme solarized
let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ }

" netrw
nnoremap <silent>\x :<C-u>Explore<CR>
let g:netrw_liststyle = 3
let g:netrw_banner = 0 " disable the directory banner
let g:netrw_bufsettings = 'noma nomod number nobl nowrap ro'
let g:netrw_list_hide= '.DS_Store$,.*\.aux$,.*\.dvi$,.*\.fdb_latexmk,.*\.fls$,.*\.synctex\.gz$,.*\.swp$,.*\.toc$'

" denite.nvim
if dein#tap('denite.nvim')
    nnoremap <silent>\f :<C-u>DeniteProjectDir file_rec<CR>
    nnoremap <silent>\b :<C-u>Denite buffer<CR>
    call denite#custom#source('buffer', 'matchers', ['matcher_fuzzy'])
    call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_ignore_globs'])
    call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
                \ [ '*~', '*.o', '*.exe', '*.bak',
                \   '.DS_Store', '*.pyc', '*.sw[po]', '*.class',
                \   'tags', 'tags-*',
                \   'target/',
                \   'node_modules/',
                \   '.*/' ])
endif

nnoremap <silent>\t :<C-u>tabnew<CR>
nnoremap <silent>\d :<C-u>b#\|bd #<CR>
nnoremap <silent><C-z> <Nop>
