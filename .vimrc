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
Plugin 'dracula/vim'
"Terminal color scheme approximation
"Bundle 'godlygeek/csapprox'
"Bundle 'w0ng/vim-hybrid'
"Bundle 'croaker/mustang-vim'

"Bundle 'Syntastic'
Bundle 'https://github.com/tpope/vim-fugitive'
"Bundle 'https://github.com/gorodinskiy/vim-coloresque.git'

Bundle 'Lokaltog/vim-easymotion'

Plugin 'bronson/vim-trailing-whitespace'

Plugin 'mattn/emmet-vim'

" Unite
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'evidens/vim-twig'

"Bundle 'jlanzarotta/bufexplorer'
"Bundle 'vim-scripts/FuzzyFinder'
Bundle 'sjbach/lusty'
Bundle 'vim-scripts/a.vim'

Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

"Autocomplete
"Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/neosnippet'
"Bundle 'Shougo/neosnippet-snippets'
"Bundle 'honza/vim-snippets'

"Cool status line
Bundle 'Lokaltog/vim-powerline'
Plugin 'jacoborus/tender'

"NERDTree
Bundle 'scrooloose/nerdtree'

"Bundle 'jdonaldson/vaxe'
Plugin 'othree/html5.vim'

Plugin 'Chiel92/vim-autoformat'

let g:vundle_lazy_load=1
Bundle 'wakatime/vim-wakatime'

filetype plugin indent on

set expandtab
set tabstop=4
set softtabstop=2
set smartindent
set hlsearch
set shiftwidth=2

setlocal cm=blowfish
let g:LustyJugglerSuppressRubyWarning = 1

"file extensions
autocmd BufNewFile,BufReadPost *.as,*.as,*.glsl,*.frag,*.vert set filetype=cpp
autocmd BufNewFile,BufReadPost *.def,*.def set filetype=json
autocmd BufNewFile,BufReadPost *.hx set filetype=haxe
"autocmd BufNewFile,BufReadPost *.twig,*.html,*.htm set syntax=html

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
inoremap <F1> <NoP>

set splitbelow
set splitright

"Key Mappings
let mapleader=","
nnoremap <silent><Leader>n :set nonumber!<CR>
nnoremap <Leader>be :LustyJuggler<CR>


nnoremap B ^
nnoremap E $

map <silent><Leader>m :noh<CR>
"map <silent><C-o> :A<CR>
map <Leader><Leader>m <Leader>lj
map <Leader>m <Leader>mss

map <silent><Leader>e :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowLineNumbers=0
let NERDTreeMinimalUI=1
  let g:NERDTreeWinSize = 46


if filereadable("make")
    set makeprg=./make
endif

"Color scheme
set background=dark
colorscheme tender
"color dracula
set t_Co=256
let g:rehash256 = 1

"Writes
cnoreabbrev git Git
command Wq wq
command Wa wa
command W w
command WQ wq
command Q q

function! s:SendGit(msg)
    :silent Git add .
    :silent Git commit -m a:msg
    :Git push
endfunction

command! -nargs=1 Sendin call s:SendGit(<f-args>)
cnoreabbrev sendin Sendin

"UI
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode

set cursorline                  " Highlight current line
set relativenumber

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

syntax on

let g:formatdef_custom_html = '"html-beautify -f - -w 140 --wrap-attributes force --wrap-attributes-indent-size 4 -s ".shiftwidth()'
let g:formatters_html = ['custom_html', 'tidy_html']

let g:formatdef_custom_js = '"js-beautify -w 140 -f - -".(&expandtab ? "s ".shiftwidth() : "t").(&textwidth ? " -w ".&textwidth : "")'
let g:formatters_javascript = ['custom_js', 'pyjsbeautify_javascript', 'jscs']

map == :Autoformat<CR>

let g:jsx_ext_required = 0

"let g:formatters_html = ['htmlbeautify', 'tidy_html']
