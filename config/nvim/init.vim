" Plugins  ------------------------------------------------------------------{{{
  call plug#begin('~/.local/share/nvim/plugged')
  filetype plugin indent on

" System {{{
  Plug 'itmammoth/doorboy.vim'
  Plug 'matze/vim-move'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'simnalamburt/vim-mundo'
  Plug 'sjl/vitality.vim'
  Plug 'taiansu/nerdtree-ag'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tmux-plugins/vim-tmux'
 " }}}

" Appeareance {{{
  Plug 'chriskempson/base16-vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'RRethy/vim-illuminate'
" }}}

" Completion {{{
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
" }}}

" Finders {{{
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
" }}}

" Movement {{{
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired' "}}} " code style {{{
  Plug 'easymotion/vim-easymotion'
" }}}

" Git {{{{
  function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
      if has('nvim')
        !cargo build --release
      else
        !cargo build --release --no-default-features --features json-rpc
      endif
    endif
  endfunction

  Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'jreybert/vimagit', {'on_cmd': ['Magit', 'MagitOnly']}
  Plug 'sgeb/vim-diff-fold'
  Plug 'junegunn/gv.vim' " }}}} " markdown {{{
  Plug 'tpope/vim-markdown', {'on_ft': 'markdown'}
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'nelstrom/vim-markdown-folding', {'on_ft': 'markdown'}
  Plug 'rhysd/vim-grammarous'
  Plug 'junegunn/goyo.vim'
  Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
" }}}

" Linting {{{
  let g:ale_completion_enabled = 0
  Plug 'w0rp/ale'
  " Plug 'autozimu/LanguageClient-neovim', {
      " \ 'branch': 'next',
      " \ 'do': 'bash install.sh',
      " \ }
" }}}

" Language {{{
  Plug 'godlygeek/tabular'

  Plug 'tpope/vim-dispatch' "
  " Plug 'c0r73x/neotags.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'janko-m/vim-test'
  Plug 'sbdchd/vim-run'
  Plug 'sheerun/vim-polyglot'
" }}}

" Javascript {{{
  Plug 'othree/yajs.vim'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'mxw/vim-jsx'
  Plug 'heavenshell/vim-jsdoc'
  Plug 'elzr/vim-json'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'Quramy/vison'
" }}}

" HTML {{{
  Plug 'mattn/emmet-vim'
  Plug 'othree/html5.vim'
  Plug 'skwp/vim-html-escape'
  Plug 'valloric/MatchTagAlways', {'on_ft': 'html'}
" }}}

" CSS {{{
  Plug 'hail2u/vim-css3-syntax'
  Plug 'ap/vim-css-color'
" }}}

  Plug 'ryanoasis/vim-devicons' " Always load last

  
  call plug#end()
  filetype plugin indent on
" }}}

" Vim Options  --------------------------------------------------------------{{{

" General Key Mappings {{{
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

  " Open .vimrc file in new tab. Think Command + , [Preferences...] but with Shift.
  map <D-<>       :tabedit ~/.neovimrc<CR>

  " Reload .vimrc
  map <leader>rv  :source ~/.neovimrc<CR>

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

" }}}

" General Options {{{
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
" }}}

" GUI Options {{{
  " set guifont=Inconsolata:h24
  " set guioptions-=T               " Remove GUI toolbar
  " set guioptions-=e               " Use text tab bar, not GUI
  " set guioptions-=rL              " Remove scrollbars
" }}}

" Appearance {{{
  let g:base16colorspace=256
  set t_Co=256
  set background=dark
  if filereadable(expand("~/.vimrc_background"))
    source ~/.vimrc_background
  else
    colorscheme base16-solarized-dark
  endif

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

  set signcolumn="yes"
  let g:gitgutter_sign_added              = ''
  let g:gitgutter_sign_modified           = ''
  let g:gitgutter_sign_removed            = ' '
  let g:gitgutter_sign_removed_first_line = '‾'
  let g:gitgutter_sign_modified_removed   = ''
" }}}

" Folding  ------------------------------------------------------------------{{{
  function! MyFoldText() " {{{
      let line = getline(v:foldstart)
      let nucolwidth = &fdc + &number * &numberwidth
      let windowwidth = winwidth(0) - nucolwidth - 3
      let foldedlinecount = v:foldend - v:foldstart

      " expand tabs into spaces
      let onetab = strpart('          ', 0, &tabstop)
      let line = substitute(line, '\t', onetab, 'g')

      let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
      " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines')
      " let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - len('lines   ')
      let fillcharcount = windowwidth - len(line)
      " return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . ' Lines'
      return line . '…'. repeat(" ",fillcharcount)
  endfunction " }}}
  set foldtext=MyFoldText()

  autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

  " autocmd FileType vim setlocal fdc=1
  set foldlevel=99

  " Space to toggle folds.
  nnoremap <Space> za
  vnoremap <Space> za
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0

  autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99

  autocmd FileType css,scss,json setlocal foldmethod=marker
  autocmd FileType css,scss,json setlocal foldmarker={,}

  autocmd FileType coffee setl foldmethod=indent
  let g:xml_syntax_folding = 1
  autocmd FileType xml setl foldmethod=syntax

  autocmd FileType html setl foldmethod=expr
  autocmd FileType html setl foldexpr=HTMLFolds()

  " autocmd FileType javascript,typescript,json setl foldmethod=syntax
  autocmd FileType javascript,typescript,typescriptreact,json setl foldmethod=syntax
" }}}

" Visual Cues {{{
  set showmatch                                      " show matching brackets
  set mat=5                                          " how many tenths of a second to blink matching brackets for
  set hlsearch                                       " highlight searched for phrases
  set incsearch                                      " highlight as you type you search phrase
  set history=1024                                   " History size
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
" }}}

" Text Formatting/Layout {{{
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
" }}}

" Files/Backups {{{
  "set backup " make backup file
  "set backupdir=$VIM\vimfiles\backup " where to put backup file
  "set directory=$VIM\vimfiles\temp " directory is the directory for temp file
  "set makeef=error.err " When using make, where should it dump the file
  set autowrite                     " Save the file when shell/cmd are run
  set autoread
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
" }}}

" Vim UI {{{
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
" }}}

" }}}

" Code Formating  -----------------------------------------------------------{{{

  nmap <silent> <leader>lf  <Plug>(ale_fix)

  let g:ale_fixers = {
    \  'bash': ['shfmt'],
    \  'c': ['clang-format'],
    \  'css': ['prettier'],
    \  'flow': ['prettier'],
    \  'graphql': ['prettier'],
    \  'javascript': ['prettier-eslint', 'eslint'],
    \  'json': ['prettier'],
    \  'jsx': ['prettier-eslint', 'eslint'],
    \  'less': ['prettier'],
    \  'markdown': ['prettier'],
    \  'scss': ['prettier'],
    \  'sh': ['shfmt'],
    \  'typescript': ['prettier'],
    \}

let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
let g:ale_sh_shfmt_options = '-i 2 -ci -p'
let g:ale_bash_shfmt_options = '-i 2 -ci'
let g:ale_javascript_prettier_eslint_use_global = 0
let g:ale_javascript_tsserver_use_global = 1

" }}}

" Completion (coc) {{{
	" use <tab> for trigger completion and navigate next complete item
	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
	endfunction

	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()

	" use <c-space>for trigger completion
	imap <c-space> coc#refresh()

	inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

	vmap <leader>=  <Plug>(coc-format-selected)
	nmap <leader>=  <Plug>(coc-format-selected)
  map <leader>-   <Plug>(coc-format)

	map <silent> <leader>ll <Plug>(coc-diagnostic-info)<cr>
	map <silent> <leader>ln <Plug>(coc-diagnostic-next)<cr>
	map <silent> <leader>lp <Plug>(coc-diagnostic-prev)<cr>
	" map <silent> <leader>lr <Plug>(coc-rename)<cr>
	map <silent> <leader>lf <Plug>(coc-fix-current)<cr>

	" Remap keys for gotos
	nmap <silent> <leader>ld <Plug>(coc-definition)
	nmap <silent> <leader>ly <Plug>(coc-type-definition)
	nmap <silent> <leader>li <Plug>(coc-implementation)
	nmap <silent> <leader>lr <Plug>(coc-references)

  " Use K for show documentation in preview window
  nnoremap <silent> <leader>lk :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  highlight! link CocErrorSign DiffDelete 
  highlight! link CocWarningSign DiffChange 
	highlight! link CocHintSign	DiffText
	highlight! link CocInfoSign DiffAdd

" }}}
" Completion (Deoplete)  ----------------------------------------------------{{{
  " let g:deoplete#enable_at_startup = 1
  " let g:deoplete#auto_complete_delay = 0
  " let g:echodoc_enable_at_startup=1

  set splitbelow
  set completeopt+=menuone,noinsert,noselect
  set completeopt-=preview
  " autocmd CompleteDone * pclose

  " function! Multiple_cursors_before()
    " let b:deoplete_disable_auto_complete=2
  " endfunction
  " function! Multiple_cursors_after()
    " let b:deoplete_disable_auto_complete=0
  " endfunction

  " let g:deoplete#file#enable_buffer_path=1

  " call deoplete#custom#source('buffer', 'mark', '')
  " call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)

  "TODO Fix or delete
  " let g:deoplete#omni_patterns = {
        " \ 'html': '',
        " \ 'css': '',
        " \ 'scss': ''
        " \ }
"}}}

" Linting (ale)  ------------------------------------------------------------{{{
  let g:ale_linters = {
    \ 'bash': ['shellcheck'],
    \ 'javascript': ['eslint'],
    \ 'ruby': ['rubocop'],
    \ 'sass': ['stylelint'],
    \ 'scss': ['stylelint'],
    \ 'sh': ['shellcheck'],
    \}

  let g:airline#extensions#ale#enabled = 1
  let g:ale_set_highlights = 1


  highlight ALEError cterm=bold,inverse
  highlight ALEWarning cterm=inverse
	highlight ALEInfo cterm=underline
  " highlight! link CocHintSign	DiffText


  let g:ale_echo_msg_error_str = ''
  let g:ale_echo_msg_warning_str = ''
  let g:ale_echo_msg_format = '%severity% %s [%linter% : %code%]'

  let g:ale_sign_error = ''
  let airline#extensions#ale#error_symbol= ''
  let g:ale_sign_warning = ''
  let airline#extensions#ale#warning_symbol = ''
  let g:ale_sign_info = 'כֿ'

	let g:ale_lint_on_save = 1
	let g:ale_lint_on_text_change = 0

  let g:ale_sign_highlight_linenrs = 1

"  }}}

" Search and Display Lists (fzf)  ----------------------------------------{{{

  map <silent> <leader>k :Ag<CR>
  map <silent> <leader>b :Buffers<CR>
  map <silent> <leader>f :GFiles<CR>
  map <silent> <leader>F :Files<CR>
  map <silent> <leader>h :HelpTags<CR>
"}}}

" Git  ----------------------------------------------------------------------{{{
  " Automatically delete Fugitive buffers that are no longer being used.
  " Otherwise, they tend to fill up the buffer list.
  "
  " Credit to Drew Neil of Vimcasts:
  " http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/

  autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}

" Javascript ----------------------------------------------------------------{{{

  " let $NVIM_NODE_LOG_FILE='nvim-node.log'
  " let $NVIM_NODE_LOG_LEVEL='warn'
  " let $NVIM_NODE_HOST_DEBUG=1

  let g:jsx_ext_required = 0
  let g:jsdoc_allow_input_prompt = 1
  let g:jsdoc_input_description = 1
  let g:jsdoc_return=0
  let g:jsdoc_return_type=0

  let g:tern#command = ['tern']
  let g:tern#arguments = ['--persistent']
  let g:tern_map_keys=1
  let g:tern#filetypes = [ 'jsx', 'javascript.jsx', 'vue', 'javascript' ]

  let g:vim_json_syntax_conceal = 0

" }}}

" Searching (AG)  -----------------------------------------------------------{{{
  if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor\ --column

    "" Use silver searcher instead of grep
    " bind K to grep word under cursor
    nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
  endif
" }}}

" Nerd Commenter  -----------------------------------------------------------{{{
  " Comment/uncomment lines
  map <leader>/   <plug>NERDCommenterToggle

  " Pad comment delimeters with spaces
  let NERDSpaceDelims = 1

  let g:NERDCustomDelimiters = {
        \ 'tmux': { 'left': '#', 'leftAlt': '##' }
        \ }
" }}}

" Nerd Tree  ----------------------------------------------------------------{{{
  " File tree browser
  noremap <nowait> \ :NERDTreeToggle<Enter>

  " File tree browser showing current file - pipe (shift-backslash)
  map \|          :NERDTreeFind<CR>
" }}}

" Undo  ---------------------------------------------------------------------{{{
  "TODO Update undo
  map <leader>u   :GundoToggle<CR>
  nmap <leader>r :Run<CR>
  nmap <leader>tn :TestNearest<CR>
  nmap <leader>tf :TestFile<CR>
  nmap <leader>ts :TestSuite<CR>
  nmap <leader>tl :TestLast<CR>
  nmap <leader>tg :TestVisit<CR>
"}}}

" Motion  -------------------------------------------------------------------{{{

  let g:EasyMotion_do_mapping = 0 " Disable default mappings
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_keys = 'mnbvcxzpoiuytrewq;lkjhgfdsa'

  " Jump from cursor up or down (jk) and to start or end of line
  map <Leader>j <Plug>(easymotion-sol-j)
  map <Leader>k <Plug>(easymotion-sol-k)
  map <Leader>J <Plug>(easymotion-eol-j)
  map <Leader>K <Plug>(easymotion-eol-k)

  " Search all visible windows for a char then jump
  nmap <leader>s{char} <Plug>(easymotion-overwin-f2)
"}}}
