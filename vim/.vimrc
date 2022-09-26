set nocompatible
filetype off

" SWP FILES DRIVE ME NUTS
set nobackup
set nowritebackup
set noswapfile

" Line numbers
set number

" Allow resizing tabs with mouse - soooo much easier
set mouse=a

" 2 space tabs, tab button = 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Disable quote concealing in JSON files
let g:vim_json_conceal=0

" Tab indent indicator
let g:indentLine_char = '▏'
let g:indentLine_color_term = 40
let g:indentLine_color_gui = '#333333'

" Windows - turn off that stupid bell thing
set belloff=all

" 2 space tabs for C/C++ files
autocmd BufRead,BufNewFile *.h setlocal tabstop=2
autocmd BufRead,BufNewFile *.c setlocal shiftwidth=2
autocmd BufRead,BufNewFile *.hpp setlocal tabstop=2
autocmd BufRead,BufNewFile *.cpp setlocal shiftwidth=2

" Typescript - for syntax highlighting (detection)
autocmd BufRead,BufNewFile *.ts setfiletype typescript

" set autoread                  " Remember last location in file
" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
" au FocusLost,WinLeave * :silent! wa

" Trigger autoread when changing buffers or coming back to vim.
" au FocusGained,BufEnter * :silent! !

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Use <C-X> for Emmet instead of <C-Y>
let g:user_emmet_leader_key=','

" Better window splits:
" move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" Control + o to open/close nerdtree panel
map <C-o> :NERDTreeToggle<CR>

" Syntax theme
set t_Co=256
syntax on

" 256 Terminal colors
set termguicolors

" vimdiff
if &diff
  map ] ]c
  map [ [c
endif

" Airline font
let g:airline_powerline_fonts = 1

" Color column at 80
set colorcolumn=80

" Run vader tests using cmd :Test
function! s:exercism_tests()
  if expand('%:e') == 'vim'
    let testfile = printf('%s/%s.vader', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(testfile)
      echoerr 'File does not exist: '. testfile
      return
    endif
    source %
    execute 'Vader' testfile
  else
    let sourcefile = printf('%s/%s.vim', expand('%:p:h'),
          \ tr(expand('%:p:h:t'), '-', '_'))
    if !filereadable(sourcefile)
      echoerr 'File does not exist: '. sourcefile
      return
    endif
    execute 'source' sourcefile
    Vader
  endif
endfunction

autocmd BufRead *.{vader,vim}
      \ command! -buffer Test call s:exercism_tests()

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Required for plugin: zivyangll/git-blame.vim
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" Allow alias commands to be ran inside vim
let $BASH_ENV = "~/.bash_aliases"

" Plugins
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" fzf: File search
Plugin 'junegunn/fzf'
" lighline: Enhanced status bar
Plugin 'itchyny/lightline.vim'
" Vim multiple cursor
Plugin 'terryma/vim-multiple-cursors'
" File viewer on the left side
Plugin 'scrooloose/nerdtree'
" Emmet
Plugin 'mattn/emmet-vim'
" Lint
Plugin 'w0rp/ale'
" Git changes visual helper
Plugin 'airblade/vim-gitgutter'
" gruvbox - styling
Plugin 'morhetz/gruvbox'
" TypeScript syntax highlighting
Plugin 'leafgarland/typescript-vim'
" Autosave
Plugin '907th/vim-auto-save'
" Autocomplete
Plugin 'ervandew/supertab'
" Jump between matching tags
Plugin 'andymass/vim-matchup'
" See git blame for highlighted line
Plugin 'zivyangll/git-blame.vim'
" Test vimscript
Plugin 'junegunn/vader.vim'
" Show indent tabs
Plugin 'Yggdroot/indentLine'
" Airline - pretty tabline
Plugin 'vim-airline/vim-airline'
" Livedown - Live markdown preview
Plugin 'shime/vim-livedown'
nmap gm :LivedownToggle
" ------ TPOPIA ------
" Handy Unix utilities
Plugin 'tpope/vim-eunuch'
" Surround with brackets, quotes, w/e
Plugin 'tpope/vim-surround'
" vim-fugitive - git in vim
Plugin 'tpope/vim-fugitive'
" Abolish - smart replace words
Plugin 'tpope/vim-abolish'

call vundle#end()            " required
filetype plugin indent on    " required

" Color scheme
" Must come after Plugin lines
let g:gruvbox_italic=0
colorscheme gruvbox
set background=dark    " Setting dark mode

