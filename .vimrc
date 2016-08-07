" vim: foldmethod=marker foldenable foldlevel=0 foldlevelstart=0
" ****** "
" Vundle " {{{1
" ****** "
" Vundle settings need to go first
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'coderifous/textobj-word-column.vim'
Plugin 'dahu/LearnVim'
Plugin 'derekwyatt/vim-fswitch'
Plugin 'derekwyatt/vim-protodef'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'hexHighlight.vim'
Plugin 'honza/vim-snippets'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-user'
Plugin 'kien/ctrlp.vim'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'lukerandall/haskellmode-vim'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'Pychimp/vim-luna'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'sjl/gundo.vim'
Plugin 'Tagbar'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'travitch/hasksyn'
Plugin 'Valloric/YouCompleteMe'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'

call vundle#end()

" *********** "
" Preferences " {{{1
" *********** "
" Settings regarding the visual aspects of vim
set hlsearch
set nowrap
set linebreak
set showbreak=↪
set breakindent
set number
set showcmd
set completeopt=menu,longest
set wildmenu
set wildmode=longest:full,full
set listchars=tab:▸\ ,nbsp:_,trail:·
set lazyredraw
set laststatus=2
" set scroll=30
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024
" Spell check
set nospell
set spelllang=el,en,sv
" How and when to fold
set foldmethod=syntax
set foldlevelstart=99
" Settings regarding code style
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab
set autoindent
set formatoptions+=jl
" Only searches that contain uppercase letters are case sensitive
set ignorecase
set smartcase
" Use incremental search
set incsearch
" Instead of unloading, hide the buffers
set hidden

" Tags settings
set tags^=./.tags
" set tags+=~/.vim/tags/stl

" Miscellaneous settings
set cryptmethod=blowfish
filetype plugin indent on
syntax on
" Set where vim saves swap/backup/undo files
set directory^=~/.vim/files/swap//,.
set backupdir=~/.vim/files/backup//,.
set undodir=~/.vim/files/undo//,.
" Set the colorscheme
set background=dark
if &term == 'xterm'
	set t_Co=256
endif
colorscheme rdark-mod
set colorcolumn=81,121

" *************** "
" Plugin settings " {{{1
" *************** "
let g:airline_exclude_preview = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:ctrlp_working_path_mode=0
let g:ctrlp_open_new_file='r'
let g:easytags_auto_update=0
let g:easytags_async=1
let g:easytags_dynamic_files=2
let g:easytags_include_members=1
let g:easytags_python_enabled=1
let g:haddock_browser="/usr/bin/chromium"
let g:LatexBox_output_type="pdf"
let g:LatexBox_viewer="evince"
let g:pandoc#modules#disabled = ['formatting']
let g:syntastic_aggregate_errors = 1
let g:syntastic_enable_signs = 0
let g:syntastic_mode_map = { "mode": "passive",
			\ "active_filetypes": ["sh", "lua", "python", "haskell"],
			\ "passive_filetypes": [] }
" let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:UltiSnipsExpandTrigger = "<C-s>"
let g:ycm_add_preview_to_completeopt=1
let g:ycm_allow_changing_updatetime=0
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf=1
let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py"
let g:ycm_register_as_syntastic_checker=0
let NERDSpaceDelims=1

" **************** "
" Custom functions " {{{1
" **************** "
" Strip trailing whitespace
function! StripTrailingWhitespaces()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	%s/\s\+$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
" Toggle between absolute and relative line numbers.
function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc
" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" Change keyboard map and enable iminsert/imsearch if necessery
function! ToggleGreekKeymap()
	if(&keymap == "")
		setlocal keymap=greek_utf-8
		echo "keymap set to greek_utf-8"
	else
		setlocal keymap=""
		echo "keymap set to default"
	endif
endfunc
" Use different comment styles based on the type of selection
function! CommentVisual() range
	let m = visualmode()
	if m ==# 'v'
		"Character-wise visual
		call NERDComment('x', "comment")
	elseif m == 'V'
		"Line-wise visual
		execute a:firstline . "," . a:lastline . "call NERDComment('x', 'sexy')"
	elseif m == "\<C-V>"
		"Block-wise visual
		call NERDComment('x', "comment")
	endif
endfunction
" Smooth scrolling
function! SmoothScroll(up)
	if a:up
		let scrollaction="\<C-Y>"
	else
		let scrollaction="\<C-E>"
	endif
	let counter=0
	while counter<&scroll
		exec "normal " . scrollaction
		redraw
		sleep 4m
		let counter+=1
	endwhile
endfunction
" Use xxd for displaying binary files
function! BinaryToggle()
	if !exists('b:is_binary')
		let b:is_binary = 0
	endif

	if b:is_binary == 0
		execute '%!xxd'
		let b:is_binary = 1
	else
		execute '%!xxd -r'
		let b:is_binary = 0
	endif
endfunction
" Replace all occurences of the word under the cursor
function! ReplaceWord()
	" Save the last search and cursor position. We need script-local variables
	" because we can't pass the function local ones to the autocmd function.
	let b:s_rpl = @/
	let b:l_rpl = line(".")
	let b:c_rpl = col(".")
	" Save the current word
	let b:w_rpl = expand("<cword>")
	" Prepare for after leaving insert mode
	augroup callback_CirtUrvOw
		autocmd!
		autocmd InsertLeave <buffer> call ReplaceWordCallback()
		" autocmd InsertEnter <buffer> normal l
	augroup END
	" Delete the word and start insert mode
	normal diw
	startinsert
endfunction
function! ReplaceWordCallback()
	" Get the new word under the cursor
	let nw = expand("<cword>")
	" Search and replace
	execute "%s/\\<" . b:w_rpl . "\\>/" . nw . "/g"
	" Restore the search buffer and the cursor position
	let @/=b:s_rpl
	call cursor(b:l_rpl, b:c_rpl)
	normal e
	" silent! call repeat#set(":call ReplaceWordCallback()<cr>", v:count)
	" We no longer need the callback function
	augroup callback_CirtUrvOw
		autocmd!
	augroup END
	augroup! callback_CirtUrvOw
endfunction

" ************ "
" Key bindings " {{{1
" ************ "
let mapleader = ","
let maplocalleader = "\\"
" Working with my .vimrc
nnoremap <silent> <leader>ve :split $MYVIMRC<CR>
nnoremap <silent> <leader>vs :source $MYVIMRC<CR>
" Mappings for fswitch.
nnoremap <silent> <Leader>h :FSHere<cr>`"
" Write with sudo
cnoremap w!! w !sudo dd of=%
" Use <Space> to unfold folds in normal mode (if any at cursor)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" Use // to toggle comments
nnoremap <silent> // :call NERDComment('n', "toggle")<CR>
vnoremap <silent> // :call CommentVisual()<CR>
nnoremap <silent> ?? :call NERDComment('n', "uncomment")<CR>
" Gundo mapping
nnoremap <F5> :GundoToggle<CR>
" Tagbar mapping
nnoremap <F6> :TagbarToggle<CR>
" NERDTree mapping
nnoremap <F4> :NERDTreeToggle<CR>
" Command-T mappings
nnoremap <silent> <Leader>e :CtrlP<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
nnoremap <silent> <Leader>t :CtrlPTag<CR>
" Some quick toggles
nnoremap <C-n> :call NumberToggle()<cr>
nnoremap <leader>sh :call HexHighlight()<cr>
nnoremap <Leader>/ :noh<CR>
nnoremap <Leader>? :set hlsearch!<CR>
nnoremap <leader>sl :set list!<CR>
nnoremap <leader>ss :set spell!<CR>
nnoremap <leader>sw :set wrap!<CR>
nnoremap <leader>sW :set wrap<CR>:noremap j gj<CR>:noremap k gk<CR>
" Show syntax highlighting groups for word under cursor
nnoremap <silent> <leader>S :call <SID>SynStack()<CR>
" Toggle between greek_utf-8 and the default keymap
nnoremap <C-l> :call ToggleGreekKeymap()<cr>
inoremap <C-l> <C-O>:call ToggleGreekKeymap()<cr>
" Update the ctags and cscope databases
nnoremap <leader>T :UpdateTags<cr>
nnoremap <leader>C :!cscope -b -R<cr>
" Smooth scrolling
nnoremap <silent> <C-U> :call SmoothScroll(1)<cr>
nnoremap <silent> <C-D> :call SmoothScroll(0)<cr>
" Convert between binary and hex representation with xxd
nnoremap <leader>x :call BinaryToggle()<cr>
" Paste from the yank register in Visual mode
vnoremap P "0p
" Replace all occurences of the word under the cursor
nnoremap <expr> <leader>r ':%s/\<'.expand('<cword>').'\>//g<left><left>'
nnoremap <silent> <leader>R :call ReplaceWord()<cr>
" Don't move when using * for searching
nnoremap <silent> * :let stay_star_view=winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
" % is kind of inaccessible and <BS> is useless in normal mode
" This is a map instead of remap because of matchit
nmap <BS> %
" Strip all trailing whitespace from the file
nnoremap <leader>W :call StripTrailingWhitespaces()<cr>
" Set the working directory to the one containing the current file
nnoremap <leader>cd :cd %:h<cr>
" Ycm commands
nmap <leader>gt :YcmCompleter GoTo<cr>
nmap <leader>gT :YcmCompleter GetType<cr>

" ************* "
" Abbreviations " {{{1
" ************* "
" e-mails
" iabbrev m@g chrissakalis@gmail.com
" iabbrev m@u Christos.Sakalis.3822@student.uu.se

" ************ "
" Autocommands " {{{1
" ************ "
" Auto-clean fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete
" Autoload created sessions
augroup sourcesession
	autocmd!
	if argc() == 0 && filereadable('Session.vim')
		autocmd VimEnter * nested :source Session.vim
	endif
augroup END
" Autoclose the preview window
" augroup closepreview
" autocmd!
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" augroup END
