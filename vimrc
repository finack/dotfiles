set nocompatible                " Don't maintain compatibility with vi
filetype off                    " Avoid a Vim/Vundle bug
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

syntax on                       " Highlight known syntaxes
filetype plugin indent on

Plugin 'VundleVim/Vundle.vim'

Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'Shougo/neocomplete.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'easymotion/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'plasticboy/vim-markdown'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'taiansu/nerdtree-ag'
Plugin 'tmux-plugins/vim-tmux'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'chriskempson/base16-vim'


call vundle#end()
filetype plugin indent on

runtime! init/**.vim

silent! source ~/.vimrc.local
