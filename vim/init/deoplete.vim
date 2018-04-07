imap <expr><TAB>
	 \ neosnippet#expandable_or_jumpable() ?
	 \    "\<Plug>(neosnippet_expand_or_jump)" :
   \ 	      pumvisible() ? "\<C-n>" : "\<TAB>"
