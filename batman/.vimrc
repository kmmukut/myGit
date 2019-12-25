"Vundle: Start"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'https://github.com/scrooloose/nerdtree.git'   "shows directory"
Plugin 'ctrlpvim/ctrlp.vim' "Fuzzy Search using ctrlP [DIR]"
Plugin 'itchyny/lightline.vim' "make vim colorful"
Plugin 'lervag/vimtex' "tex plug in"
Plugin 'airblade/vim-gitgutter' "for Git repo"
call vundle#end()            
filetype plugin indent on    
filetype plugin on
"Vundle:end"

syntax on
colorscheme murphy


set laststatus=2   "for lightline"
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
"set relativenumber "show relativenumbering" "
set number 
set autoindent
set showmatch
set spell spelllang=en_us



"For proper tabbing and bracket insertion"
inoremap {<cr> {<cr>}<c-o><s-o>
inoremap [<cr> [<cr>]<c-o><s-o>
inoremap (<cr> (<cr>)<c-o><s-o>



