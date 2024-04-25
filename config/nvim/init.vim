""" Plugins
call plug#begin('~/.local/share/nvim/plugged')
filetype plugin indent on

"""" System
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'simnalamburt/vim-mundo'
Plug 'taiansu/nerdtree-ag'

"""" Appearance
Plug 'jrudess/vim-foldtext' " Pretty display of folded text
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'RRethy/vim-illuminate'

"""" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"""" Finders
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

"""" Movement
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

"""" Language
Plug 'godlygeek/tabular'
Plug 'tmux-plugins/vim-tmux'

Plug 'tpope/vim-dispatch'
" Plug 'c0r73x/neotags.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'janko-m/vim-test'
Plug 'sbdchd/vim-run'
Plug 'sheerun/vim-polyglot'

"""" Markdown
Plug 'dhruvasagar/vim-table-mode'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

"""" Initialization
Plug 'ryanoasis/vim-devicons' " Always load last
call plug#end()
filetype plugin indent on

""" General Key Mappings
let mapleader = ","
let maplocalleader = ";"

" Make Y consistent with D and C
map Y           y$

" Move between screens
map <leader>w   ^Ww
" map <leader>=   ^W=
map <leader>j   ^Wj
map <leader>k   ^Wk

" Easy access to the shell
map <Leader><Leader> :!

map <Leader>q :q<cr>
map <Leader>Q :qa!<cr>

" Open .vimrc file in new tab
map <leader>ve       :vs ~/.dotfiles/config/nvim/init.vim<CR>

" Reload .vimrc
map <leader>vr  :source ~/.dotfiles/config/nvim/init.vim<CR>

map <leader>vc :vs ~/.dotfiles/config/nvim/cheatsheet.md<CR>

" Undo/redo - Doesn't MacVim already have this?
map <D-z>       :earlier 1<CR>
map <D-Z>       :later 1<CR>

" Fast scrolling
nnoremap <C-e>  3<C-e>
nnoremap <C-y>  3<C-y>

" Previous/next quickfix file listings (e.g. search results)
map <M-D-Down>  :cn<CR>
map <M-D-Up>    :cp<CR>

" Previous/next buffers
map <M-D-Left>  :bp<CR>
map <M-D-Right> :bn<CR>

" Delete all buffers unless unsaved changes
map <leader>da :bufdo silent! bdelete<CR>

"indent/unindent visual mode selection with tab/shift+tab
vmap <tab>      >gv
vmap <s-tab>    <gv

" In command-line mode, <C-A> should go to the front of the line, as in bash.
cmap <C-A> <C-B>

" Copy current file path to system pasteboard
map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>
map <leader>C :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%").":".line(".")<CR>

" Disable middle mouse button, F1
map      <MiddleMouse> <NOP>
imap     <MiddleMouse> <NOP>
map      <F1>          <NOP>
imap     <F1>          <NOP>

" Disable arrow keys
inoremap <Up>          <NOP>
inoremap <Down>        <NOP>
inoremap <Left>        <NOP>
inoremap <Right>       <NOP>
noremap  <Up>          <NOP>
noremap  <Down>        <NOP>
noremap  <Left>        <NOP>
noremap  <Right>       <NOP>

" No need for ex mode
nnoremap Q             <NOP>
" or recording macros
map      q             <NOP>

""" General Options
set nocompatible                " Don't maintain compatibility with vi
syntax on                       " Highlight known syntaxes

set notimeout                   " No command timeout
set showcmd                     " Show typed command prefixes while waiting for operator
set mouse=a                     " Use mouse support in XTerm/iTerm.
set number                     " Line numbers
set relativenumber
set rnu
set nowrap                     " No wrapping
set backspace=indent,eol,start " Let backspace work over anything.
set clipboard=unnamed
set ffs=unix,mac               " support these in this order
filetype on                    " detect the type of file
filetype plugin on             " load filetype plugins
set viminfo+=!                 " make sure it can save viminfo
set modelines=1                " enable modelines in files

""" GUI Options
" set guifont=Inconsolata:h24
" set guioptions-=T               " Remove GUI toolbar
" set guioptions-=e               " Use text tab bar, not GUI
" set guioptions-=rL              " Remove scrollbars

""" Appearance
set t_Co=256
syntax enable
let base16colorspace=256
set background=light
colorscheme base16-solarized-light

function! AirlineInit()
  let g:airline_section_x = airline#section#create([])
  let g:airline_section_z = airline#section#create(['%l/%L :%3v'])
  " let g:airline_section_z = airline#section#create(['%3p%%'.spc, 'linenr', ':%3v'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" let g:airline_theme = g:colors_name
let g:airline_theme = 'base16_solarized'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#wordcount#enabled = 0

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 0

	" let g:airline_section_x = '' "Strip the text from the filetype and just show the nerdfont
" let g:airline_section_z = airline#section#create(['%3p%%'.spc, 'linenr',  ':%3v'])
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_skip_empty_sections = 1

set updatetime=1000

" set signcolumn = 3
let g:gitgutter_sign_added              = ''
let g:gitgutter_sign_modified           = ''
let g:gitgutter_sign_removed            = ' '
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed   = ''

""" Folding
let g:FoldText_placeholder = ''
let g:FoldText_line = '﮷'
let g:FoldText_multiplication = ' '

autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" autocmd FileType vim setlocal fdc=1
set foldlevel=99

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

autocmd FileType vim setlocal fde=getline(v\:lnum)=~'^\"\"'?'>'.(matchend(getline(v\:lnum),'\"\"*')-2)\:'='
autocmd FileType vim setlocal foldmethod=expr
autocmd FileType vim setlocal foldlevel=0

autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99

autocmd FileType css,scss,json setlocal foldmethod=marker
autocmd FileType css,scss,json setlocal foldmarker={,}

autocmd FileType coffee setl foldmethod=indent
let g:xml_syntax_folding = 1
autocmd FileType xml setl foldmethod=syntax

autocmd FileType html setl foldmethod=expr
autocmd FileType html setl foldexpr=HTMLFolds()

autocmd FileType javascript,typescript,typescriptreact,json setl foldmethod=syntax

""" Visual Cues
set showmatch                                      " show matching brackets
set mat=5                                          " how many tenths of a second to blink matching brackets for
set hlsearch                                       " highlight searched for phrases
set incsearch                                      " highlight as you type you search phrase
set history=1024                                   " History size
set list
set listchars=trail:◇,tab:»·,extends:>,precedes:<
set so=7                                           " Keep x lines (top/bottom) for scope
set novisualbell                                   " don't blink
set noerrorbells                                   " no noises
" Statusline from ~1994 => 2011
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%05l,%04v][%LL:%p%%]

" Statusline prior to Airline
" set statusline=[%n]                             " buffer number
" set statusline+=\ %<%.99f                       " tail of the filename
                                                " " set statusline+=\ [%{strlen(&fenc)?&fenc:'none'}, " file encoding
" set statusline+=\ %m                            " modified flag
" set statusline+=[
" set statusline+=%{&ff},                         " file format
" set statusline+=%R                              " read only flag
" set statusline+=%Y                              " filetype
" set statusline+=]
" set statusline+=%=                              " left/right separator
" set statusline+=%-16(%{fugitive#statusline()}%) " git branch
" set statusline+=%l/%LL                          " cursor line/total lines
" set statusline+=\ %c%VC                         " cursor column
" set statusline+=\ %P                            " percent through file
" set statusline=%{bufferline#generate_string()}
let g:bufferline_echo=0

set laststatus=2 " always show the status line
set hidden                      " Allow hidden, unsaved buffers
set splitright                  " Add new windows towards the right
set splitbelow                  " ... and bottom

""" Text Formatting/Layout
set fo=tcrqn      " See Help (complex)
set ai            " autoindent
set si            " smartindent
set smarttab      " Use shiftwidth to tab at line beginning
set cindent       " do c-style indenting
set tabstop=2     " tab spacing (settings below are just to unify it)
set softtabstop=2 " unify
set shiftwidth=2  " unify
set expandtab     " Give me spaces or give me death
set nowrap        " do not wrap lines

""" Files/Backups
"set backup " make backup file
"set backupdir=$VIM\vimfiles\backup " where to put backup file
"set directory=$VIM\vimfiles\temp " directory is the directory for temp file
"set makeef=error.err " When using make, where should it dump the file
set wildmode=list:longest         " activate tab auto-complete for file paths
set autoread                      " No prompt for file changes outside Vim
set swapfile                      " Keep swapfiles
set wildignore+=tags              " Ignore tags when globbing.
set wildignore+=tmp/**            " ...Also tmp files.
set wildignore+=public/uploads/** " ...Also uploads.
set wildignore+=public/images/**  " ...Also images.
set wildignore+=vendor/**         " ...Also vendor.
set isk+=_,$,@,%,#,-              " none of these should be word dividers, so make them not be
set wildignore+=.git,*.o,tmp/**,vendor/rails/**
set directory=~/.vim-tmp,~/tmp,/var/tmp,/tmp
set backupdir=~/.vim-tmp,~/tmp,/var/tmp,/tmp

""" Vim UI
set lsp=0                            " space it out a little more (easier to read)
set wildmenu  wildmode=full          " turn on wild menu
set ruler                            " Always show current positions along the bottom
set cmdheight=2                      " the command bar is 2 high
set number                           " turn on line numbers
set numberwidth=3
set cpoptions+=n                     " show wrapped lines in the line number gutter
                                     " Hitting ctrl-n ctrl-n whill toggle the display of numbers
:nmap <C-N><C-N> :set invnumber<CR>
set lz                               " do not redraw while running macros (much faster) (LazyRedraw)
set hid                              " you can change buffer without saving
                                     " set backspace=2                                               " make backspace work normal
set whichwrap+=<,>,h,l               " backspace and cursor keys wrap to
set mouse=a                          " use mouse everywhere
set shortmess=atI                    " shortens messages to avoid 'press a key' prompt
set report=0                         " tell us when anything is changed via :...
set noerrorbells                     " don't make noise
                                     " make the splitters between windows be blank
set fillchars+=vert:\ ,stl:\ ,stlnc:\ " display spaces in fill chars
set scrolloff=3                      " Scroll when the cursor is 3 lines from edge
set cursorline                       " Highlight current line
set laststatus=2                     " Always show statusline
set encoding=utf8

" Write all writeable buffers when changing buffers or losing focus.
set autowriteall                " Save when doing various buffer-switching things.
autocmd BufLeave,FocusLost * silent! wall  " Save anytime we leave a buffer or MacVim loses focus.

""" Completion (coc)
	" use <tab> for trigger completion and navigate next complete item
	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
	endfunction

" Install via :CocInstall coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()

	" use <c-space>for trigger completion
	imap <c-tab> coc#refresh()

	inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
	vmap <leader>=  <Plug>(coc-format-selected)
	nmap <leader>=  <Plug>(coc-format-selected)
map <leader>-   <Plug>(coc-format)

	map <silent> <leader>gl <Plug>(coc-diagnostic-info)<cr>
	map <silent> <leader>]g <Plug>(coc-diagnostic-next)<cr>
	map <silent> <leader>[g <Plug>(coc-diagnostic-prev)<cr>
	map <silent> <leader>lr <Plug>(coc-rename)<cr>
	map <silent> <leader>gf <Plug>(coc-fix-current)<cr>

	" Remap keys for gotos
	nmap <silent> <leader>gd <Plug>(coc-definition)
	nmap <silent> <leader>gy <Plug>(coc-type-definition)
	nmap <silent> <leader>gi <Plug>(coc-implementation)
	nmap <silent> <leader>gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> <leader>gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)


vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" highlight! link CocErrorSign DiffDelete 
" highlight! link CocWarningSign DiffChange 
	" highlight! link CocHintSign	DiffText
	" highlight! link CocInfoSign DiffAdd

""" Completion
set splitbelow
set completeopt+=menuone,noinsert,noselect
set completeopt-=preview

""" Search and Display Lists (fzf)
map <silent> <leader>k :Ag<CR>
map <silent> <leader>b :Buffers<CR>
map <silent> <leader>f :GFiles<CR>
map <silent> <leader>F :Files<CR>
map <silent> <leader>h :HelpTags<CR>

""" Searching (AG)
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column

  "" Use silver searcher instead of grep
  " bind K to grep word under cursor
  nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
endif

""" Nerd Commenter
" Comment/uncomment lines
map <leader>/   <plug>NERDCommenterToggle

" Pad comment delimeters with spaces
let NERDSpaceDelims = 1

let g:NERDCustomDelimiters = {
      \ 'tmux': { 'left': '#', 'leftAlt': '##' }
      \ }

""" Nerd Tree
" File tree browser
noremap <nowait> \ :NERDTreeToggle<Enter>

" File tree browser showing current file - pipe (shift-backslash)
map \|          :NERDTreeFind<CR>

""" Undo
"TODO Update undo
map <leader>u   :GundoToggle<CR>
nmap <leader>r :Run<CR>
nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tg :TestVisit<CR>

""" Markdown
let g:vim_markdown_frontmatter = 1  " for YAML format
nmap <leader>p <Plug>MarkdownPreviewToggle

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.md setlocal tw=80

""" Spell
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run(fzf#wrap({'source': suggestions, 'sink': function("FzfSpellSink")}))
endfunction
nnoremap z= :call FzfSpell()<CR>

" enable terminal codes for undercurl and under colors
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
hi SpellBad cterm=Undercurl ctermfg=red ctermbg=NONE term=Reverse gui=Undercurl guisp=Red
hi SpellLocal cterm=Undercurl ctermfg=14 ctermbg=NONE term=Reverse gui=Undercurl guisp=Red
hi SpellCap cterm=Undercurl ctermfg=12 ctermbg=NONE term=Reverse gui=Undercurl guisp=Red
hi SpellRare cterm=Undercurl ctermfg=13 ctermbg=NONE term=Reverse gui=Undercurl guisp=Red

" set spell spelllang=en_us termguicolors
