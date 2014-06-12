execute pathogen#infect()

set background=dark

colorscheme jellybeans

set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
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

noremap <F7> :Autoformat<CR><CR>
nmap <silent> <C-D> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
nmap <silent> <C-E> :TagbarToggle<CR>


map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

