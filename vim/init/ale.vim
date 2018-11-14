" Asynchronous Lint Engine (ALE)
" Limit linters used for JavaScript.
let g:ale_linters = { 'javascript': ['eslint','flow'] }

highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)

let g:ale_sign_error = '!' " could use emoji
let g:ale_sign_warning = '?' " could use emoji
let g:ale_statusline_format = ['X %d', '? %d', '']

" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'

" Map keys to navigate between lines with errors and warnings.
" nnoremap <leader>an :ALENextWrap<cr>
" nnoremap <leader>ap :ALEPreviousWrap<cr>
