" Tab specific options
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set shiftround
set nojoinspaces
set textwidth=80

" Custom mappings
nnoremap <silent> <localleader>a :Tabularize /\s=\s<CR>
vnoremap <silent> <localleader>a :Tabularize /\s=\s<CR>

" Set the compiler and reset the cmdheight
compiler ghc
set cmdheight=1
