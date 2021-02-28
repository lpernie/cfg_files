" set t_ti="" QUESTO fa riamanere il testo sullo schermo
hi link perlConditional PreProc
map #1 :split:e
map #2 
map #3 :vsplit:e
map g :0
set nocompatible
set secure
" no beeping!!
set vb t_vb=
set autowrite
" set autoindent
set noignorecase
set ruler
set showmatch
set showmode wrapmargin=0 report=1 
set sw=8 ts=6
set dir=. 
set joinspaces
set bs=2 backup noshowcmd 
set nobackup
set nowrap sidescroll=1
" set expandtab
set notextauto notextmode
"set wrapmargin=-10000
set wrapmargin=2
" set bex=.bak
" set title
 set hlsearch
set list
"set listchars= eol:$, tab:->, trail:^
set listchars=tab:>-
set warn
if has("terminfo")
  set t_Co=8
  set t_Sf=[3%p1%dm
  set t_Sb=[4%p1%dm
else
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif 
set background=light
syntax on
map!    <BACKSPACE>
map! <DELETE> <BACKSPACE>
" map #2 :wq
" map ]m mzywoi:!man pa |/usr/l3/bin/less"zdd

" Only do this part when compiled with support for autocommands.
if has("autocmd")

 " In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78

 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  "autocmd BufRead *                       set formatoptions=tcql nocindent comments&
  "autocmd BufRead *.c,*.cc,*.h,*.hh,*.ddl set filetype=cpp formatoptions=croql  cindent comments=sr:/*,mb:*,el:*/,://
  autocmd BufRead *                       set formatoptions=tcql nocindent comments&
  autocmd BufRead *.c,*.cc,*.h,*.hh,*.ddl set filetype=cpp formatoptions=croql  nocindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!
  " Enable editing of gzipped files
  "   read: set binary mode before reading the file
  "   uncompress text in buffer after reading
  "  write: compress file after writing
  " append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre  *.gz set bin
  autocmd BufReadPost,FileReadPost  *.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost  *.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost  *.gz set nobin
  autocmd BufReadPost,FileReadPost  *.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost  *.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost  *.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost  *.gz !gzip <afile>:r

  autocmd FileAppendPre     *.gz !gunzip <afile>
  autocmd FileAppendPre     *.gz !mv <afile>:r <afile>
  autocmd FileAppendPost    *.gz !mv <afile> <afile>:r
  autocmd FileAppendPost    *.gz !gzip <afile>:r
 augroup END
 augroup bz2
  " Remove all bz2 autocommands
  au!

  " Enable editing of bzipped files
  "   read: set binary mode before reading the file
  "   uncompress text in buffer after reading
  "  write: compress file after writing
  " append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre  *.bz2 set bin
  autocmd BufReadPost,FileReadPost  *.bz2 let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost  *.bz2 '[,']!bunzip2
  autocmd BufReadPost,FileReadPost  *.bz2 set nobin
  autocmd BufReadPost,FileReadPost  *.bz2 let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost  *.bz2 execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost  *.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost  *.bz2 !bzip2 <afile>:r

  autocmd FileAppendPre     *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre     *.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost    *.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost    *.bz2 !bzip2 <afile>:r
 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 0
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif

endif " has("autocmd")
" ========================================================================
" PGP - encryption and decryption
" ========================================================================
"
" encrypt
nmap ;e :%!pgp -feast 2>/dev/tty
vmap ;e :%!pgp -feast 2>/dev/tty
" decrypt
nmap ;d :/^-----BEG/,/^-----END/!pgp -f 2>/dev/tty
vmap ;d :/^-----BEG/,/^-----END/!pgp -f 2>/dev/tty
" sign 
nmap ;s :,$! pgp -fast +clear 2>/dev/tty
" 
nmap ;v :,/^-----END/w !pgp -m
"
"
" Elijah http://www.mathlab.sunysb.edu/~elijah/pgppub.html says :
" The significant feature is that stderr is redirected independently of
" stdout, and it is redirected to /dev/tty which is a synonym for the current
" terminal on Unix.  I don't know why the ||sleep 4 stuff is there, but it is
" harmless so I left it. Since csh is such junk, special rules are used if you
" are using it (tcsh, too). ksh and bash should use the sh form. zsh, et al:
" consult your manual.  The #<num> format is used to map function keys. If you
" terminal does not support the requested function key, use a literal #<num>.
" Not all of the clones correctly support this.
"

"   ,rl = run latex (on current file)
map ,rl :!latex %
"   ,rd = create ps file (from dvi file of current file)
map ,rd :!dvips %<.dvi 
set mouse=
set clipboard=unnamed
syn region myFold start="{" end="}" transparent fold
syn sync fromstart

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
