" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".hg" --ignore ".svn" --ignore ".git" --ignore ".bzr" --hidden -g ""'
endif

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1

  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-c> <Plug>(unite_all_exit)
endfunction

call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('buffer,file,file_mru,file_rec', 'sorters', 'sorter_rank')

let g:unite_enable_short_source_names = 1
let g:unite_enable_start_insert = 1
let g:unite_prompt = '» '
let g:unite_source_directory_mru_long_limit = 3000
let g:unite_source_file_mru_long_limit = 3000
let g:unite_source_history_yank_enable = 1

nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>F :<C-u>UniteWithBufferDir -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>m :<C-u>Unite -no-split -buffer-name=mapping  mapping<cr>
nnoremap K :<C-u>Unite -buffer-name=grep grep:.::<C-R><C-W><CR>:cw<CR>
nnoremap <leader>s :<C-u>Unite -buffer-name=search line:forward:wrap -start-insert -no-quit<cr>
nnoremap <leader>S :<C-u>Unite -buffer-name=search line:backward:wrap -start-insert -no-quit<cr>
nnoremap <space>/ :Unite grep::-iR:<cr>
