execute pathogen#infect()

set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set smarttab


set number
set showcmd
set cursorline
set wildmenu
set lazyredraw
set showmatch

set incsearch
set hlsearch

nnoremap <leader><space> :nohlsearch<CR>

set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent


syntax on

filetype plugin indent on

nmap <silent> <C-D> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0

