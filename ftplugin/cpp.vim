" Use astyle to format the code
execute "set formatprg=astyle\\ --options=" . expand("~/.vim/cpp.astyle") 
" Autoformat comments
set textwidth=80
set formatoptions+=c
