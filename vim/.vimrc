"quick fixes for a more usable vim on a new box in a single line
" set hls ic is nu noswf
" these are the same as
" set hlsearch    " highlight all search results
" set ignorecase  " do case insensitive search
" set incsearch   " show incremental search results as you type
" set number      " display line number
" set noswapfile  " disable swap file
" from https://swordandsignals.com/2020/12/13/5-lines-in-vimrc.html`

execute pathogen#infect()
syntax on
filetype plugin indent on
let g:solarized_termcolors=256
set t_Co=256
syntax enable
set background=dark
let g:solarized_termtrans = 1 " This gets rid of the grey background

colorscheme solarized
hi Normal guibg=NONE ctermbg=NONE
set number
set relativenumber
set noswapfile
set incsearch
set hlsearch
set ignorecase
let g:elm_format_autosave=1
set shiftwidth=2
set tabstop=2
set showcmd
let mapleader = (' ')

" trailing whitepace highlight
highlight link sensibleWhitespaceError Error
autocmd Syntax * syntax match sensibleWhitespaceError excludenl /\s\+\%#\@<!$\| \+\ze\t/ display containedin=ALL

" map ctrl-\ t to run GoTests
map <Leader>t GoTest


if has('mac')
    " fzf installed via homebrew
		set rtp+=/usr/local/opt/fzf
elseif has('unix')
    " fzf installed via linuxbrew
		set rtp+=/home/emurphy/.linuxbrew/opt/fzf
endif

let g:ale_fixers = {
	    \ 'javascript': ['prettier'],
	    \ 'typescript': ['prettier'],
	    \ 'css': ['prettier'],
	    \}

if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    " g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
let g:neovide_transparency = 0.0
let g:transparency = 0.8
let g:neovide_background_color = '#0f1117'.printf('%x', float2nr(255 * g:transparency))

endif

