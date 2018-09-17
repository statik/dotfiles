execute pathogen#infect()
syntax on
filetype plugin indent on
let g:solarized_termcolors=256
set t_Co=256
syntax enable
set background=dark
let g:solarized_termtrans = 1 " This gets rid of the grey background
colorscheme solarized
set number
set relativenumber
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
