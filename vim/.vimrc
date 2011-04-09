"--------
" Coil VIMRC
"--------
"--------
" GENERAL SETTINGS 
"--------

let $MYVIMRC = $HOME."/.vimrc"

"--------
" TEXT OPTIONS
"--------
set encoding=utf-8

" expand tabs to spaces
set expandtab

" tab character is 4 spaces
set tabstop=4

" tab key input is 4 spaces
set softtabstop=4

" indent width is 4 spaces
set shiftwidth=4

" allow backspace deletion over indentation
" end of line and start of insert mode
set backspace=indent,eol,start

" don't act as vi
set nocompatible

" turn of the beep
set noerrorbells

" searching, incremental search, ignore case but use smartcase
set incsearch
set ignorecase
set smartcase

" update the title of the window
set title

" undo levels
set undolevels=500

" change priority for these suffixes
set suffixes+=.class,.hi,.so,.a,.pyc,.la
set suffixes-=.h

" change command history size
set history=1000

" sharing windows clipboard
set clipboard+=unnamed

" write buffer when leaving
set autowrite

" no backup or swap
set nowb
set nobackup
set noswapfile

" autoreread when a file is changed from outside
set autoread

" indenting options
set autoindent
set smartindent

"--------
" VISUAL OPTIONS
"--------

" set colorscheme
set t_Co=256
colorscheme xoria256

" enable syntax highlightning
syntax enable

" always display the status line
set laststatus=2

" line numbering
set number
set numberwidth=4

" number of lines for the command area
set cmdheight=2

" set how tabs, eols look when you use :set list
set listchars=tab:>-,eol:$,nbsp:%,trail:-,extends:>,precedes:<
if $LANG =~ ".*\.UTF-8$" || $LANG =~ ".*utf8$" || $LANG =~ ".*utf-8$"
    set listchars+=tab:»·,trail:·,precedes:…,extends:…
endif

" always show the current mode
set showmode

" set the highlightning options...
set highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws 

" show the file position 
set ruler

" always show a report when lines were changed
set report=0

" don't show special chars by default
set nolist

" show matching brackets
set showmatch

" time to show matching brackets
set matchtime=2


"------
" MISC
"------

" enable automatic filetype detection
filetype on

" the character for "expansion" or "tab-competion" on the command line
set wildchar=<TAB>

" don't wrap lines
set nowrap

" disable folding
set nofoldenable

" show selected chars, line or screen size when in visual mode
set showcmd

" show this many lines below or above the cursor always
set scrolloff=10

"------
" Key mappings
"------

" unmap arrow keys, left=h, right=l, up=k, down=j, pageUp=C-b, pageDown=C-f
map <Left> \
map <Right> \
map <Up> \
map <Down> \
map <PageUp> \
map <PageDown> \

imap <Left> <nop>
imap <Right> <nop>
imap <Up> <nop>
imap <Down> <nop>
imap <PageUp> <nop>
imap <PageDown> <nop>


" move current line up or down
nmap <C-j> :m+<CR>
nmap <C-k> :m-2<CR>
" move the currently selected visual block up or down
vmap <C-j> :m'>+<CR> gv
vmap <C-k> :m'<-2<CR> gv

" move the current line tab left or tab right
nmap <C-l> >>
nmap <C-h> <<
"move the current selected visual block left or right
vmap <C-l> >gv
vmap <C-h> <gv

" step through buffers
map <C-p> :bp <CR>
map <C-n> :bn <CR>

" map F12 to reload the vim config
map <F12> :so $MYVIMRC <CR> :echo "Reloaded" $MYVIMRC <CR>

"------
" AUTOCOMMANDS
"------

autocmd FileType hs         source ~/.vim/syntax/haskell.vim
autocmd FileType java       source ~/.vim/syntax/java.vim
autocmd FileType tex        source ~/.vim/syntax/tex.vim
autocmd FileType dot        source ~/.vim/syntax/dot.vim
autocmd FileType asm,a      source ~/.vim/syntax/asm.vim
autocmd FileType make       setlocal noexpandtab


autocmd FileType python     call s:MyPythonSettings()


"------
" FUNCTIONS
"------

function! s:MyPythonSettings()
  setlocal sw=4 ts=4 et
  setlocal cindent
  setlocal comments=:#
  setlocal tags+=./python.ctags
  setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
  setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'…
  setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  setlocal omnifunc=pythoncomplete#Complete
endfunction
