set nocompatible " vim mode

" runtime path manipulation (pathogen)
execute pathogen#infect()

" Powerline
set laststatus=2  " always display status line
set showtabline=2 " always show tab line
set noshowmode    " hide default mode text (e.g. '--INSERT--')
set t_Co=256      " terminal 256 colors

" Navigation
set relativenumber " relative line numbers (easier to navigate)
set scrolloff=2    " amount of scroll in top/bottom of screen
set ruler          " always show cursor position

" Text modification
set backspace=indent,eol,start " backscape over autoindent, line breaks and
                               " start of insert

" Syntax highlighting
syntax on

" Indentation
filetype plugin indent on
set shiftwidth=2  " amount of spaces for indentation
set autoindent    " auto indentation
set expandtab     " spaces, not tabs
set softtabstop=2 " tab space value

" Commands
set showcmd    " display incomplete commands
set history=50 " keep n lines of command history

" Autocomplete
set wildmenu " enhanced command-line completion

" Search
set ignorecase " affects search and replace
set smartcase  " case-insensitive when lowercase, case-sensitive otherwise. 
               " \C for case sensitive lowercase (e.g. /the\C)
set incsearch  " incremental search

" Mappings
" write as root
" https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %
" CTags
map <Leader>rt :!ctags --tag-relative --extra=+f -Rf.git/tags --exclude=.git,pkg --languages=-javascript,sql<CR><CR>

" NERDTree shortcuts
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeMapActivateNode = '<SPACE>'

" Tags
set tags+=.git/tags

" Neckbeard settings
let ruby_space_errors = 1
let c_space_errors = 1
set colorcolumn=81
highlight ColorColumn ctermbg=235 guibg=#262626
