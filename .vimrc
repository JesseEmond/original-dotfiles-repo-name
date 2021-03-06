" Plugins 
call plug#begin('~/.vim/plugged')

" Syntax
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-git'
Plug 'vim-ruby/vim-ruby'
Plug 'moll/vim-node'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'leshill/vim-json'
Plug 'tpope/vim-markdown'
Plug 'ap/vim-css-color'
" Plugins
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
Plug 'kien/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'JesseEmond/lightline-seoul256.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'easymotion/vim-easymotion'
Plug 'derekwyatt/vim-scala'
Plug 'bkad/CamelCaseMotion'
Plug 'scrooloose/syntastic'
Plug 'edkolev/tmuxline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'airblade/vim-gitgutter'


call plug#end()

" Vimrc
autocmd! bufwritepost .vimrc source % " auto-reload of vimrc while modifying it

" Status bar
set laststatus=2  " always display status line
set showtabline=2 " always show tab line
set noshowmode    " hide default mode text (e.g. '--INSERT--')
set t_Co=256      " terminal 256 colors


" Leader
let mapleader=","

" Escape
:imap jk <Esc>

" Color scheme
colorscheme seoul256

" Text navigation
set relativenumber             " relative line numbers (easier to navigate)
set number                     " absolute line on current line (hybrid)
set scrolloff=2                " amount of scroll in top/bottom of screen
set ruler                      " always show cursor position
highlight MatchParen ctermbg=4 " highlight matching brace with diff color
call camelcasemotion#CreateMotionMappings('<leader>') " camel case navigation

" Text display
set wrap
set linebreak
set showbreak=…

" File navigation
set suffixesadd+=.js,.rb " allow to "gf" on filename to goto file
set path+=lib/**,test/** " e.g. :find looks in there for files

" Split navigation / creation
map <silent> <C-h> :call WinMove('h')<cr>
map <silent> <C-j> :call WinMove('j')<cr>
map <silent> <C-k> :call WinMove('k')<cr>
map <silent> <C-l> :call WinMove('l')<cr>

" Split settings
set splitbelow
set splitright

" ControlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Text modification
set backspace=indent,eol,start " backscape over autoindent, line breaks and
                               " start of insert
set clipboard=unnamedplus      " default to linux clipboard
set pastetoggle=<F2>           " paste mode with shortcut

" Syntax highlighting
syntax on
let g:jsx_ext_required = 0 " JSX in .js files

" Indentation
filetype plugin indent on
set shiftwidth=4  " amount of spaces for indentation
set autoindent    " auto indentation
set expandtab     " spaces, not tabs
set softtabstop=4 " tab space value
set cino+=(0      " indentation around parentheses (e.g. parameters)
au FileType javascript setl sw=2 sts=2 et

" Commands
set showcmd    " display incomplete commands
set history=50 " keep n lines of command history

" Syntastics
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_scala_checkers = []
nmap <F3> :SyntasticToggleMode<cr>

" Autocomplete
set wildmenu " enhanced command-line completion

" YouCompleteMe config
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
highlight Pmenu ctermfg=255 ctermbg=235 guifg=#ffffff guibg=#000000
highlight PmenuSel ctermfg=235 ctermbg=255 guifg=#000000 guibg=#ffffff

" Ultisnips config
let g:UltiSnipsExpandTrigger="<c-j>"

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
" remove extra whitespace
nmap <leader><space> :%s/\s\+$<cr>

" Lightline configuration
let g:lightline = {}
let g:lightline.colorscheme = 'seoul256'

" Goyo bindings 
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" RSpec.vim configuration
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "!bundle exec rspec {spec}"

"""""""""""""
" Functions "
"""""""""""""

" Window movement shortcuts
" move to the window in the direction shown, or create a new window if none
" available.
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
      if (match(a:key,'[jk]'))
        wincmd v
      else
        wincmd s
      endif
      exec "wincmd ".a:key
    endif
endfunction
