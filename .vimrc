"vimrc, very nice
set nocompatible

"Pathogen
call pathogen#infect()
filetype off

"Bundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

"Molokai color scheme
Bundle 'tomasr/molokai'
"Terminal color scheme approximation
"Bundle 'godlygeek/csapprox'
"Bundle 'w0ng/vim-hybrid'
"Bundle 'croaker/mustang-vim'

"Bundle 'Syntastic'
Bundle 'https://github.com/tpope/vim-fugitive'
"Bundle 'https://github.com/gorodinskiy/vim-coloresque.git'

Bundle 'Lokaltog/vim-easymotion'

Plugin 'itchyny/thumbnail.vim'

Plugin 'bronson/vim-trailing-whitespace'

" Unite
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'

"Autocomplete
"Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/neosnippet'
"Bundle 'Shougo/neosnippet-snippets'
"Bundle 'honza/vim-snippets'

"Cool status line
Bundle 'Lokaltog/vim-powerline'

"NERDTree
Bundle 'scrooloose/nerdtree'

Bundle 'jdonaldson/vaxe'


let g:vundle_lazy_load=1
Bundle 'wakatime/vim-wakatime'

filetype plugin indent on
syntax on

set expandtab
set tabstop=4
set softtabstop=4
set smartindent
set hlsearch
set shiftwidth=4

setlocal cm=blowfish
let g:LustyJugglerSuppressRubyWarning = 1

"file extensions
autocmd BufNewFile,BufReadPost *.as,*.as,*.glsl,*.frag,*.vert set filetype=cpp
autocmd BufNewFile,BufReadPost *.def,*.def set filetype=json
autocmd BufNewFile,BufReadPost *.hx set filetype=haxe

set undodir=$HOME/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000
set wildignore=*.o,*.pyc
set wildmenu
set laststatus=2
set autoread
set virtualedit=onemore

set hidden

set ignorecase
set smartcase
set incsearch
set nu
set scrolloff=3
set showmatch

set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪

"Tab handling
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <F1> <NoP>

set splitbelow
set splitright

"Key Mappings
let mapleader=","
nnoremap <silent><Leader>n :set nonumber!<CR>

nnoremap B ^
nnoremap E $

map <silent><Leader>m :noh<CR>
map <silent><F2> <Leader>be
map <silent><C-o> :A<CR>

map <silent><Leader>r :Thumbnail<CR>

map <C-i> :call vaxe#ImportClass()<CR>

map <silent><Leader>e :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

if filereadable("make")
    set makeprg=./make
endif

"Color scheme
set background=dark
colorscheme molokai
set t_Co=256
let g:rehash256 = 1

syn include syntax/css/vim-coloresque.vim

"Writes
cnoreabbrev git Git
command Wq wq
command Wa wa
command W w
command WQ wq
command Q q

function! SendGit()
    :silent Git add .
    :silent Git commit -m"auto commit"
    :Git push
endfunction

command Sendin call SendGit()
cnoreabbrev sendin Sendin

"UI
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode

set cursorline                  " Highlight current line

set mouse=a
set ttyfast
set lazyredraw

"let g:Powerline_symbols = 'fancy'

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
let g:CSApprox_hook_post = ['hi clear SignColumn']

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd                 " Show partial commands in status line and
endif

if has('statusline')
    set laststatus=2
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

"UNITE
let g:unite_source_history_yank_enable = 1
try
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry

" search a file in the filetree
nnoremap <space><space> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
nnoremap <space>r <Plug>(unite_restart)
