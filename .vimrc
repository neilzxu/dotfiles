" Ensure that we are in modern vim mode, not backwards-compatible vi mode
set visualbell
set nocompatible
set backspace=indent,eol,start

call plug#begin('~/.local/share/nvim/plugged')

" ----- Vim as a programmer's text editor -----------------------------
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/a.vim'

Plug 'vim-syntastic/syntastic'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'posva/vim-vue'
Plug 'sekel/vim-vue-syntastic'

Plug 'fholgado/minibufexpl.vim'

Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf', {'build': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'eugen0329/vim-esearch'

"Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'

" ----- Working with Git ----------------------------------------------
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" ----- Other text editing features -----------------------------------
Plug 'Raimondi/delimitMate'

" ----- man pages, tmux -----------------------------------------------
Plug 'jez/vim-superman'
Plug 'christoomey/vim-tmux-navigator'

" ----- Syntax plugins ------------------------------------------------
Plug 'jez/vim-c0'
Plug 'jez/vim-ispc'
Plug 'kchmck/vim-coffee-script'
Plug 'rust-lang/rust.vim'

"Cosmetics for vim
Plug 'altercation/vim-colors-solarized'
Plug 'iCyMind/NeoSolarized'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()



set ruler
set number

"Enable filetype detection and syntax hilighting
syntax enable
filetype on
filetype indent on
filetype plugin on
set hlsearch

set termguicolors

"set the colorscheme
colorscheme NeoSolarized
"let g:solarized_termcolors=64
set background=dark

"vim-airline/vim-airline settings
set guifont=Menlo_for_Powerline_Regular:h10
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled=1

" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- fzf -----

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <silent> ,t :Files<CR>
nnoremap <silent> ,b :Buffers<cr>
nnoremap <silent> ,r :Tags<cr>

let g:fzf_tags_command = 'ctags -R'

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" ------ vim-esearch settings -------
let g:esearch = {
  \ 'adapter':    'git',
  \ 'backend':    'nvim',
  \ 'out':        'win',
  \ 'batch_size': 1000,
  \ 'use':        ['visual', 'hlsearch', 'last'],
  \}



" ----- formatting and linting -----

let g:neoformat_enabled_python=['yapf']
augroup fmt
    autocmd!
    autocmd BufWritePre *.py undojoin | Neoformat
""    autocmd BufWritePre *.py :call ale#Lint()
augroup END

" ---set typescript syntax highlighting/language association------
autocmd BufNewFile,BufRead *.ts set filetype=javascript
" -----syntastic---------

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_vue_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lint --'

"nerdtree settings
"autocmd vimenter * NERDTree
let g:python3_host_prog = '/home/neil/miniconda3/bin/python3'
let g:deoplete#enable_at_startup = 1
set completeopt-=preview
" ------- python language server ------
" use TAB to manually autocomplete with deoplete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

let g:LanguageClient_serverCommands = {
      \ 'python': ['pyls']
      \ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_trace = 'verbose'

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)
" Indent as intelligently as vim knows how
set smartindent

" ----- minibufexpl settings -------
let g:miniBufExplAutoStart = 0
let g:miniBufExplBuffersNeeded = 1


" Show multicharacter commands as they are being typed
set showcmd
set t_Co=16 "16 color

set encoding=utf-8 "UTF-8 character encoding
set tabstop=2  "4 space tabs
set shiftwidth=2  "4 space shift
set softtabstop=2  "Tab spaces in no hard tab mode
set expandtab  " Expand tabs into spaces
set autoindent  "autoindent on new lines
set showmatch  "Highlight matching braces
set ruler  "Show bottom ruler
set equalalways  "Split windows equal size
set formatoptions=croq  "Enable comment line auto formatting
set wildignore+=*.o,*.obj,*.class,*.swp,*.pyc "Ignore junk files
set title  "Set window title to file
set hlsearch  "Highlight on search
set ignorecase  "Search ignoring case
set smartcase  "Search using smartcase
set incsearch  "Start searching immediately
set scrolloff=5  "Never scroll off
set wildmode=longest,list  "Better unix-like tab completion
set cursorline  "Highlight current line
set clipboard=unnamed  "Copy and paste from system clipboard
set lazyredraw  "Don't redraw while running macros (faster)
set autochdir  "Change directory to currently open file
set nocompatible  "Kill vi-compatibility
set wrap  "Visually wrap lines
set linebreak  "Only wrap on 'good' characters for wrapping
set backspace=indent,eol,start  "Better backspacing
set linebreak  "Intelligently wrap long files
set ttyfast  "Speed up vim
set nostartofline "Vertical movement preserves horizontal position
set fileformat=unix
set ff=mac
"set mouse=a "Enable mouse clicky stuff
" Strip whitespace from end of lines when writing file
autocmd BufWritePre * :%s/\s\+$//e

" Syntax highlighting and stuff
filetype plugin indent on
syntax on

" Get rid of warning on save/exit typo
command WQ wq
command Wq wcommand W w
