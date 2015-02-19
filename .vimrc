filetype on  " Automatically detect file types.
 
 " Add recently accessed projects menu (project plugin)
set viminfo^=!
set cf  " Enable error files & error jumping.
set ruler  " Ruler on
set autoindent
set list
filetype indent on
filetype plugin on

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set splitright
set splitbelow


set bg=dark
syn on
set incsearch hlsearch
set ignorecase
set smartcase
set scrolloff=2
set wildmode=longest,list
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set number
set laststatus=2
set statusline=%f%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [%l;%L;%p%%,%v]\
set softtabstop=2

autocmd BufWritePre * :%s/\s\+$//e      
