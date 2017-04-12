set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'rip-rip/clang_complete'
Plugin 'kien/ctrlp.vim'
Plugin 'quramy/tsuquyomi'
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'
Plugin 'leafgarland/typescript-vim'
Plugin 'jason0x43/vim-js-indent'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-jdaddy'
Plugin 'shougo/vimproc'

call vundle#end() 

filetype plugin indent on 

set wildignore+=*/node_modules/*,*/bower_components/*,*/target/*

let g:ctrlp_custom_ignore = '^(node_modules|bower_components)'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:clang_library_path='/usr/lib/llvm-3.8/lib'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set tabstop=4
set shiftwidth=4
set expandtab

let g:tsuquyomi_use_dev_node_module=2
let g:tsuquyomi_tsserver_path='/usr/lib/node/bin/tsserver'
let g:tsuquyomi_shortest_import_path = 1

fixdel 
set backspace=2

syntax enable
colorscheme solarized
set number

set clipboard=unnamedplus

set backupdir=~/.vim/backup
set directory=~/.vim/swp
set wildmenu
set wildmode=longest,list

nmap <C-T> :NERDTree <CR>
nmap <C-E> <l> :JavaImportOrganize <CR>
let vim_markdown_preview_hotkey='<C-L>'
