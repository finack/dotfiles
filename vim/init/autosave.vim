" only write if needed and update the start time after the save
function! UpdateFile()
  if ((localtime() - b:start_time) >= 1)
    update
    let b:start_time=localtime()
  else
    echo "Only " . (localtime() - b:start_time) . " seconds have elapsed so far."
  endif
endfunction
