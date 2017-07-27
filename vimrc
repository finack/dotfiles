set nocompatible                " Don't maintain compatibility with vi
filetype off                    " Avoid a Vim/Vundle bug
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

syntax on                       " Highlight known syntaxes
filetype plugin indent on

Plugin 'VundleVim/Vundle.vim'

" UI Changes
Plugin 'bling/vim-airline'
Plugin 'Shougo/neocomplete.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'chriskempson/base16-vim'

" Movement
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'easymotion/vim-easymotion'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'taiansu/nerdtree-ag'
" Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'

" Language
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'fatih/vim-go'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-dispatch'


call vundle#end()
filetype plugin indent on

runtime! init/**.vim

silent! source ~/.vimrc.local
