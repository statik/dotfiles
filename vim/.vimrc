execute pathogen#infect()
syntax on
filetype plugin indent on
set background=dark
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
