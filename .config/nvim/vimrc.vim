" Ensure that we are in modern vim mode, not backwards-compatible vi mode

"~/.config/nvim/init.vim is nvim vimrc path

set visualbell
set nocompatible
set backspace=indent,eol,start



"if !has('nvim') && empty(glob('~/.vim/autoload/plug.vim'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"elseif has('nvim') && empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
"  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif
"
"
"call plug#begin('~/.local/share/nvim/plugged')

" ---- Copilot
"Plug 'github/copilot.vim'
"let b:copilot_enabled = 0

" ---- Varius navigation
"Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'jistr/vim-nerdtree-tabs'
"Plug 'scrooloose/nerdcommenter'
"Plug 'vimwiki/vimwiki'
"Plug 'Konfekt/FastFold'

" ----- Latex
"Plug 'lervag/vimtex'

" ---- pandoc
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'


"Plug 'junegunn/fzf', {'build': './install --all' }
"set rtp+=~/.fzf
"Plug 'junegunn/fzf.vim'
"Plug 'eugen0329/vim-esearch'
"
"
"" ----- Working with Git ----------------------------------------------
"Plug 'airblade/vim-gitgutter'
"Plug 'tpope/vim-fugitive'
"
"" ----- Other text editing features -----------------------------------
"Plug 'Raimondi/delimitMate'

" ------ Formatters/linters --------
" Plug 'w0rp/ale'
"Plug 'sbdchd/neoformat'


" ----- Python plugins --------------

"Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
"Plug 'davidhalter/jedi'
"if has('nvim')
"  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"  Plug 'deoplete-plugins/deoplete-jedi'
"  Plug 'autozimu/LanguageClient-neovim', {
"      \ 'branch': 'next',
"      \ 'do': 'bash install.sh',
"      \ }
"endif

" ----------- R plugin
"Plug 'jalvesaq/Nvim-R'



"Plug 'rust-lang/rust.vim'
"
"" ----- Cosmetics for vim ------
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'vim-airline/vim-airline'
"
"call plug#end()


set ruler
set number

"Enable filetype detection and syntax hilighting
syntax enable
filetype on
filetype indent on
filetype plugin on
set hlsearch

nmap ; :

syntax on
color dracula

"vim-airline/vim-airline settings
set guifont=Menlo_for_Powerline_Regular:h10
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled=1


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

let g:neoformat_enabled_python=['yapf', 'docformatter --black']
let g:neoformat_enabled_r=['styler']
let g:neoformat_run_all_formatters = 1
augroup fmt
    autocmd!
    autocmd BufWritePre *.rs undojoin | Neoformat
    autocmd BufWritePre *.{r,R} undojoin | Neoformat
augroup END
"let g:deoplete#enable_at_startup = 1

set completeopt-=preview

" ---set typescript syntax highlighting/language association------
autocmd BufNewFile,BufRead *.ts set filetype=typescript

" ------ nerdtree settings ------
"autocmd vimenter * NERDTree

map <silent> ,n :NERDTreeToggle<CR>


" ------- python language server ------
" use TAB to manually autocomplete with deoplete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<tab>"

let g:LanguageClient_serverCommands = {
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
      \ 'python': ['pyls'],
      \ 'cpp': ['cquery', '--language-server', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery"}'],
      \ 'r': ['R', '--slave', '-e', 'languageserver::run()']
\ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '~/.vim/settings.json'
let g:LanguageClient_trace = 'verbose'
let $RUST_BACKTRACE = 1
let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
let g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

" set signcolumn=yes

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> S :call LanguageClient#textDocument_documentSymbol()<CR>

" -------- ale ----------
"" 'python': ['pyls', 'mypy'],
let b:ale_linters = {
    \ 'python': ['flake8'],
    \ 'rust': ['rls', 'rustfmt'],
    \ 'typescript': ['prettier', 'tslint'],
    \ }

" -------- vim-tex --------------

let g:tex_flavor = 'plain'
" integrate deoplete with vimtex

" Pandoc settings
let g:pandoc#filetypes#pandoc_markdown = 1
let g:pandoc#command#autoexec_on_writes = 1
let g:pandoc#biblio#sources = 'c'
let g:pandoc_command_autoexec_command = "Pandoc! html"
let g:pandoc#biblio#use_bibtool = 1
" Deoplete integration
"if has('nvim')
"    call deoplete#custom#var('omni', 'input_patterns', {
"              \ 'tex': g:vimtex#re#deoplete
"              \})
"   Translate this to lazynvim lua config
"    call deoplete#custom#var('omni', 'input_patterns', {
"      \ 'pandoc': '@'
"      \})
"
"
"endif
let g:pandoc#folding#fastfolds = 1
" Automatically swithces working directory to directory of opened file for
" opandoc files
"" autocmd FileType pandoc :lchdir %:p:h
" ------------------ R settrings
let R_auto_start = 1
let R_assign = 0

"" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1
"" R commands in R output are highlighted
let g:Rout_more_colors = 1



set t_ut=
" Tmux redraw
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
endif


" Show multicharacter commands as they are being typed
set showcmd
" Allow for switching between buffers w/o saving
set hidden
"set t_Co=16 "16 color

set encoding=utf-8 "UTF-8 character encoding
set tabstop=2  "4 space tabs
set shiftwidth=4  "4 space shift
set softtabstop=4  "Tab spaces in no hard tab mode
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
set nocompatible  "Kill vi-compatibility
set wrap  "Visually wrap lines
set linebreak  "Only wrap on 'good' characters for wrapping
set backspace=indent,eol,start  "Better backspacing
set linebreak  "Intelligently wrap long files
set ttyfast  "Speed up vim
set nostartofline "Vertical movement preserves horizontal position
set fileformat=unix
set ff=mac
" Strip whitespace from end of lines when writing file
autocmd BufWritePre * :%s/\s\+$//e

" Syntax highlighting and stuff
filetype plugin indent on
syntax on

" Get rid of warning on save/exit typo
command WQ wq
command Wq wcommand W w
