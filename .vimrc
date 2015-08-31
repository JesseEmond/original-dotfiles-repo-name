" Plugins 
call plug#begin('~/.vim/plugged')

" syntax
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-git'
Plug 'vim-ruby/vim-ruby'
Plug 'moll/vim-node'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'leshill/vim-json'
Plug 'tpope/vim-markdown'
" plugins
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-unimpaired'
Plug 'gorkunov/smartpairs.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'tpope/vim-vinegar'
Plug 'Valloric/YouCompleteMe'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'


call plug#end()

" Powerline
set laststatus=2  " always display status line
set showtabline=2 " always show tab line
set noshowmode    " hide default mode text (e.g. '--INSERT--')
set t_Co=256      " terminal 256 colors

" Color scheme
colorscheme seoul256

" Text navigation
set relativenumber             " relative line numbers (easier to navigate)
set number                     " absolute line on current line (hybrid)
set scrolloff=2                " amount of scroll in top/bottom of screen
set ruler                      " always show cursor position
highlight MatchParen ctermbg=4 " highlight matching brace with diff color

" File navigation
set suffixesadd+=.js,.rb " allow to "gf" on filename to goto file
set path+=lib/**,test/** " e.g. :find looks in there for files

" Text modification
set backspace=indent,eol,start " backscape over autoindent, line breaks and
                               " start of insert
set clipboard=unnamedplus      " default to linux clipboard
set pastetoggle=<F2>           " paste mode with shortcut

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

" YouCompleteMe config
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
highlight Pmenu ctermfg=255 ctermbg=235 guifg=#ffffff guibg=#000000
highlight PmenuSel ctermfg=235 ctermbg=255 guifg=#000000 guibg=#ffffff

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

" Tags
set tags+=.git/tags

" Neckbeard settings
let ruby_space_errors = 1
let c_space_errors = 1
set colorcolumn=81
highlight ColorColumn ctermbg=235 guibg=#262626
highlight LineNr ctermfg=DarkGrey

" Goyo bindings 
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave LimeLight!
