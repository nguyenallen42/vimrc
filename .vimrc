" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

" Adding Pathogen.vim
call pathogen#infect()

" Setup stuffs for Golang
set rtp+=$GOROOT/misc/vim

" ============== General ============== "
" ===================================== "

colorscheme wombat256mod
set background=dark

if has('gui_running')
  "set guifont=Inconsolata\ Medium\ 12
  set guifont=DejaVu\ Sans\ Mono\ 10
endif

" Control the initial size of the vim Window
set lines=50 columns=100

set showmode          " Show the current mode
set showmatch         " Show matching brackets.
set ignorecase        " Do case insensitive matching
set smartcase         " Do smart case matching
set incsearch         " Incremental search
set autowrite         " Automatically save before commands like :next and :make
set autoread          " Automatically reads a file that has been changed on disk
set hidden            " Hide buffers when they are abandoned
set mouse=a           " Enable mouse usage (all modes)
set nu                " Set line numbering, but only in the current split
":au WinEnter * :setlocal nu
":au WinLeave * :setlocal nonu
set nobackup          " Remove backup/swap files (although they can be nice)
set noswapfile
set noerrorbells      " No beeping
set mousehide         " Hide the mouse when typing
set guioptions=ac     " Get rid of Gvim's menus
set splitright        " New vertical splits should be on the right 
set splitbelow        " New horizontal splits should be on the bottom
" set visualbell
set relativenumber  " Not sure if I want this yet
"set showcmd          " Show (partial) command in status line.
syntax on             " Syntax highlighting
"set colorcolumn=80    " No line should be more than 80 chars
"highlight ColorColumn ctermbg=7
"highlight ColorColumn guibg=Grey

" Set Omni-completion
set ofu=syntaxcomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

" Set a better status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]

" Automatically saves GVim when switching window focus
au FocusLost * :wa

" Tell Vim to always put a status line in, even if there is only one
" window
set laststatus=2

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


" ============== Folding ============== "
" ===================================== "

"This is annoying
" set foldmethod=indent   " Folds based on indents
set foldenable        " No folds by default

" Save folds between sessions
autocmd BufWinLeave .* mkview
autocmd BufWinEnter .* silent loadview 


" ============ Indentation ============ "
" ===================================== "

set expandtab
set softtabstop=4
set autoindent
set tabstop=4            " Number of spaces a tab accounts for
set shiftwidth=4         " Number of spaces for autoindent

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·


" ========= Simple Remappings ========= "
" ===================================== "

" Change the <leader> key to ,
let mapleader=","

" Aliasing accidental shifts
cnoreabbrev W w
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev Q q

" Remapping arrow keys to move along splits
nnoremap <Up>        <C-W>k
nnoremap <Down>      <C-W>j
nnoremap <Left>      <C-W>h
nnoremap <Right>     <C-W>l

" Saving more keystrokes woot!
nnoremap ; :

" If you have a long line, this will change j,k to jump to next row,
" instead of next line
nnoremap j gj
nnoremap k gk

" Mappings for copying and pasting from an external clipboard
" (e.g. from the browser or another app)
nnoremap <silent> <leader>y "+y
nnoremap <silent> <leader>p "+p

" Reselects visual blocks after indentation
vnoremap < <gv
vnoremap > >gv

" ===== Plugins/Plugin Remappings ===== "
" ===================================== "

" Installing Ctrl-P for fast file opening
set runtimepath^=~/.vim/bundle/ctrlp.vim


" Syntastic ignore Horn files
let g:syntastic_mode_map = { 'mode': 'active',
                               \ 'passive_filetypes': ['hn'] }

" Using Powerline fonts for Airline
let g:airline_powerline_fonts=1

" Turn on/off NERDTree with <F1>
nmap <F1> :NERDTreeToggle<CR>

" Remap vim-flake8 to F2
autocmd FileType python map <buffer> <F2> :call Flake8()<CR>


" ========== Language Syntax ========== "
" ===================================== "

" Horn files for CS164
autocmd BufNewFile,BufReadPost *.hn set filetype=cpp
