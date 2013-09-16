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
nnoremap <silent> <localleader>a :Tabularize /\s\zs=\ze\s/l1<CR>
vnoremap <silent> <localleader>a :Tabularize /\s\zs=\ze\s/l1<CR>

" Set the compiler and reset some annoying settings
compiler ghc
set cmdheight=1
set balloonexpr=
