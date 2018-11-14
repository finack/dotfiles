set nocompatible                " Don't maintain compatibility with vi
filetype off                    " Avoid a Vim/Vundle bug

syntax on                       " Highlight known syntaxes
filetype plugin indent on

call plug#begin('~/.vim/plugged')



" UI Changes
Plug 'bling/vim-airline'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'airblade/vim-gitgutter'
" Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'kien/ctrlp.vim'
" Plug 'majutsushi/tagbar'
Plug 'tmux-plugins/vim-tmux'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'

" Movement
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'taiansu/nerdtree-ag'

" Language
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'tpope/vim-dispatch'
Plug 'c0r73x/neotags.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'janko-m/vim-test'
Plug 'sbdchd/vim-run'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'


let g:deoplete#enable_at_startup = 1
call plug#end()
filetype plugin indent on

runtime! init/**.vim

silent! source ~/.vimrc.local
