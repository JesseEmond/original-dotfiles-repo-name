" runtime path manipulation (pathogen)
execute pathogen#infect()

" Powerline
set laststatus=2  " always display status line
set showtabline=2 " always show tab line
set noshowmode    " hide default mode text (e.g. '--INSERT--')
set t_Co=256      " terminal 256 colors

" Navigation
set relativenumber " relative line numbers (easier to navigate)

" Visual
syntax on

" Indentation
filetype plugin indent on
set shiftwidth=2  " amount of spaces for indentation
set smartindent   " auto indentation
set expandtab     " spaces, not tabs
set softtabstop=2 " tab space value

" Autocomplete
set wildmenu " enhanced command-line completion

" Mappings
" write as root
" https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %


" NERDTree shortcuts
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeMapActivateNode = '<SPACE>'
