setlocal textwidth=80
setlocal spell
" For some strange reason, relativenumber makes vim very slow
setlocal norelativenumber
setlocal number
" setlocal formatoptions+=a
" When writing math, we want the default keymap
function! MathKeymap()
	if !exists('s:previous_keymap')
		let s:previous_keymap = ""
	endif
	if (&keymap != "")
		let s:previous_keymap = &keymap
		call ToggleGreekKeymap()
	else
		execute "setlocal keymap=" . s:previous_keymap
		let s:previous_keymap = ""
	endif
endfunction
inoremap <silent> $ <c-o>:call MathKeymap()<cr>$
