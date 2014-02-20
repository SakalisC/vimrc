" Use astyle to format the code
execute "set formatprg=astyle\\ --options=" . expand("~/.vim/cpp.astyle") 
" Autoformat comments
set textwidth=80
set formatoptions+=c
" ignore C++ related binaries
set wildignore+=*.o,*.obj,*.a,*.lib,*.elf
" Format using clang-format
nnoremap <leader>cf :pyf ~/.vim/clang-format.py<cr>
