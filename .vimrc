set rtp+=/usr/lib/python3.4/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2
set relativenumber

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

set shiftwidth=2 " amount of spaces for indentation
set softtabstop=2 " tab space value
set expandtab " spaces, not tabs
set smartindent " auto indentation

syntax on " syntax highlighting

set wildmenu

" Allow saving of files as sudo when I forgot to start vim using sudo.
" https://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" runtime path manipulation (pathogen)
execute pathogen#infect()

" NERDTree shortcut
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeMapActivateNode = '<SPACE>'
