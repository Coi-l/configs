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

" set gui font
set guifont=Monospace\ 8

"------
" MISC
"------

" enable automatic filetype detection
filetype on
filetype plugin indent on
syntax on

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

"-----------------------------------------------------------------------------
" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces

highlight ExtraWhitespace ctermbg=darkred guibg=#ff0000
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space.
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

"-----------------------------------------------------------------------------

" map F2 to toggle the function list
map <F2> :TlistToggle <CR>
" map F3 to toggle list on off
map <F3> :set list! <CR>
" map F12 to reload the vim config
map <F12> :so $MYVIMRC <CR> :echo "Reloaded" $MYVIMRC <CR>

" map F7 to 'compile' option
map <F7> :make
noremap <C-k><C-f> mzgg=G 'z<CR> :echo "Formated file" <CR>

" map TAB to switch windows
map <Tab> <C-w><C-w>

map <m-o> :FufCoverageFile <CR>
map <m-O> :FufBuffer <CR>


" map Ctrl-space to auto complete / omni complete
"if has("gui")
"inoremap <C-Space> <C-x><C-o>
"else
"inoremap <Nul> <C-x><C-o>
"endif

" highlight trailing whitespace
"highlight TrailWhitespace ctermbg=red guibg=red
" match TrailWhitespace /\s\+$\| \+\ze\t/
" activate whitespace highlight even when Syntax highlight is on
"autocmd Syntax * syn match TrailWhitespace /\s\+$\| \+\ze\t/


"------
"Private commands
"------
"map W to w to prevent mistakes
command! W w

"------
" POPUP MENU OPTION (omnicompletion)
"------
" insert only matched text, show menu even for one item
set completeopt=longest,menuone
" make Enter select the current highlighted item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" when pressing C-p or C-n automatically select the last or first item in the
" list by simulating up/down press
inoremap <expr> <C-p> pumvisible() ? '<C-p>' : '<C-p><C-r>=pumvisible() ? "\<lt>Up>" : ""<CR>'
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"------
" SET GUI WINDOW SIZE
"------
if has("gui_running")
    set columns=100
    " set lines=50
endif


"------
" AUTOCOMMANDS
"------

autocmd FileType hs         source ~/.vim/syntax/haskell.vim
autocmd FileType java       call s:MyJavaSettings()
autocmd FileType tex        source ~/.vim/syntax/tex.vim
autocmd FileType dot        source ~/.vim/syntax/dot.vim
autocmd FileType asm,a      source ~/.vim/syntax/asm.vim
autocmd FileType make       setlocal noexpandtab
autocmd FileType gitcommit	call s:MyGitCommitSettings()

autocmd BufRead *.pys       set filetype=python
autocmd FileType python     call s:MyPythonSettings()
autocmd FileType pys        call s:MyPythonSettings()
autocmd FileType c,h,cpp,cc call s:MyCSettings()

autocmd BufRead .bash_aliases set filetype=sh
"------
" FUNCTIONS
"------
function! s:MyGitCommitSettings()
	setlocal textwidth=70
endfunction

function! s:MyJavaSettings()
	source ~/.vim/syntax/java.vim
	setlocal expandtab
	setlocal tabstop=4
	setlocal softtabstop=4
	setlocal shiftwidth=4
	setlocal textwidth=100
endfunction

function! s:MyCSettings()
    source ~/.vim/syntax/c.vim
    setlocal cindent
    " make unclosed parantheses new line start at first
    " whitspace after paren
    setlocal cinoptions=(0,u0:0
    setlocal comments=sl:/*,mb:\ *,elx:\ */

    " mark lines over 80 chars with grey
    hi rightMargin guibg=slategray | match rightMargin /\%79v.*$/

    " autocmd FileType c,h setlocal tags+=~/.vim/systags
    setlocal tags=./tags,tags
    setlocal omnifunc=ccomplete#Complete
    setlocal completeopt=menu,preview,menuone,longest
    setlocal complete=.,w,b,u,t,i
	setlocal expandtab
    setlocal tabstop=8
	setlocal softtabstop=8
	setlocal shiftwidth=8

	let c_C99=1
    let c_c_vim_compatible=1
    let c_comment_strings=1
    let c_comment_numbers=1
    let c_comment_types=1
    let c_warn_nested_comments=1
    let c_cpp_comments=1
    let c_ansi_typedefs=1
    let c_ansi_constants=1
    let c_posix=1
    let c_comment_date_time=1
    let c_minlines=25
    let c_C89=1
    let c_gnu=1
    let c_syntax_for_h=1

endfunction

function! QualcommFile()
    setlocal tabstop=3
    setlocal softtabstop=3
    setlocal shiftwidth=3
endfunction

function! RepoFile()
    setlocal tabstop=2
    setlocal softtabstop=2
    setlocal shiftwidth=2
endfunction

function! s:MyPythonSettings()
    "pep8 friendly
    setlocal noic
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
    setlocal textwidth=120
    setlocal smarttab
    setlocal expandtab
    setlocal comments=:#
    setlocal tags+=./python.ctags
    setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
    setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
    setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    setlocal omnifunc=pythoncomplete#Complete
endfunction

" helper function to toggle hex mode
function! s:ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        "set status
        let b:editHex=0
        "return to normal editing
        %!xxd -r
    endif
    "restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction
