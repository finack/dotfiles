" When writing a buffer.
call neomake#configure#automake('w')

" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)

" When reading a buffer (after 1s), and when writing.
call neomake#configure#automake('rw', 1000)

let g:neomake_open_list = 2
