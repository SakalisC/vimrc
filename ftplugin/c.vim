" Use astyle to format the code
execute "set formatprg=astyle\\ --options=" . expand("~/.vim/c.astyle") 
" Autoformat comments
set textwidth=80
set formatoptions+=c
" ignore C related binaries
set wildignore+=*.o,*.obj,*.a,*.lib,*.elf
