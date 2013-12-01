" Keybindings
" -----------

let mapleader = ","
let maplocalleader = ";"

" Make Y consistent with D and C
map Y           y$

" Search
nmap <leader>s  :%s/
vmap <leader>s  :s/

" Split screen
" map <leader>v   :vsp<CR>

" Move between screens
map <leader>w   ^Ww
map <leader>=   ^W=
map <leader>j   ^Wj
map <leader>k   ^Wk

" Open .vimrc file in new tab. Think Command + , [Preferences...] but with Shift.
map <D-<>       :tabedit ~/.vimrc<CR>

" Reload .vimrc
map <leader>rv  :source ~/.vimrc<CR>

" Undo/redo - Doesn't MacVim already have this?
map <D-z>       :earlier 1<CR>
map <D-Z>       :later 1<CR>

" Auto-indent whole file
map <leader>=   mzgg=G'z :delmarks z<CR>:echo "Reformatted."<CR>

map <leader>u   :GundoToggle<CR>

" Fast scrolling
nnoremap <C-e>  3<C-e>
nnoremap <C-y>  3<C-y>

" File tree browser
map \           :NERDTreeToggle<CR>

" File tree browser showing current file - pipe (shift-backslash)
map \|          :NERDTreeFind<CR>

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

map <Leader>f   :CtrlP<CR>
map <Leader>F   :CtrlPBuffer<CR>
map <leader>t   :CtrlPTag<cr>
map <leader>T   :CtrlPBufTag<cr>

nmap <leader>gv :Gitv --all<cr>
nmap <leader>gV :Gitv! --all<cr>
vmap <leader>gV :Gitv! --all<cr>

"" ctags moved to git hook
" ctags with rails load path
" map <leader>t :!rails runner 'puts $LOAD_PATH.join(" ")' \| xargs /usr/local/bin/ctags -R public/javascripts<CR>
" map <leader>T :!rails runner 'puts $LOAD_PATH.join(" ")' \| xargs rdoc -f tags<CR>

" ctags with bundler load path
" map <leader>c :!~/.rvm/bin/ruby -rbundler/setup -e 'puts $LOAD_PATH.join(" ")' \| xargs /usr/local/bin/ctags -R public/javascripts<CR>

" Comment/uncomment lines
map <leader>/   <plug>NERDCommenterToggle

" In command-line mode, <C-A> should go to the front of the line, as in bash.
cmap <C-A> <C-B>

" Copy current file path to system pasteboard
map <silent> <D-C> :let @* = expand("%")<CR>:echo "Copied: ".expand("%")<CR>
map <leader>C :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%").":".line(".")<CR>

" Disable middle mouse button, F1
map <MiddleMouse>   <Nop>
imap <MiddleMouse>  <Nop>
map <F1>            <Nop>
imap <F1>           <Nop>

" Easy access to the shell
map <Leader><Leader> :!

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind ,g (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <leader>k :Ag<SPACE>

" Recalculate diff when it gets messed up.
nmap du :diffupdate<CR>

" Show Tags
map <Leader>l <ESC>:Tlist<RETURN> " (normal mode) brings up the tag list
