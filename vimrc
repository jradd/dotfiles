scriptencoding utf-8
set encoding=utf-8
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'bling/vim-airline'
Bundle 'ervandew/supertab'
Bundle 'plasticboy/vim-markdown'
Bundle 'digitaltoad/vim-jade'
Bundle 'kchmck/vim-coffee-script'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'chase/vim-ansible-yaml'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-haml'
Bundle 'vim-ruby/vim-ruby'
Bundle 'othree/html5.vim'
Bundle 'vim-scripts/HTML-AutoCloseTag'
Bundle 'ap/vim-css-color'
Bundle 'hail2u/vim-css3-syntax'

" -------------------------------------------------------------------
" basic options
" -------------------------------------------------------------------
set laststatus=2                  " always show the status line
set cmdheight=2                   " and use a two-line tall status line
set showcmd                       " show the command
set noshowmode                    " don't show the mode, vim-airline will do that for us
set autoindent                    " turns it on
set smartindent                   " does the right thing (mostly) in programs
set linespace=3                   " prefer a slight higher line height
set wrap                          " use line wrapping
set textwidth=79                  " at column 79
set formatoptions=qrn1
set ruler                         " display current cursor position
set list                          " show invisible characters
set listchars=tab:▸\ ,eol:¬,trail:⋅,nbsp:␣,extends:❯,precedes:❮
set showmatch                     " show matching brackets
set number                        " except for the current line - absolute number there
set backspace=indent,eol,start    " make backspace behave in a sane manner
set mousehide                     " hide mouse when typing
set foldenable                    " enable code folding
set history=1000
set ffs=unix,mac,dos              " default file types
set autoread                      " automatically update file when editted outside of vim

nnoremap <C-n> :call NumberToggle()<cr>

" use absolute numbers when Vim loses focus
:au FocusLost * :set norelativenumber
:au FocusLost * :set number
:au FocusGained * :set nonumber
:au FocusGained * :set relativenumber

" use absolute number when in insert mode, relative otherwise
autocmd InsertEnter * :set norelativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set nonumber
autocmd InsertLeave * :set relativenumber

" -------------------------------------------------------------------
" Navigation and movement
" -------------------------------------------------------------------
" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" use <C>hjkl to switch between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" -------------------------------------------------------------------
" What to do with files and focus
" -------------------------------------------------------------------
set autowrite           " write out old file when switching between files
set autoread            " reload files changed on disk, i.e. via `git checkout`
au FocusLost * :wa      " save file when Vim loses focus
set hidden              " switch beteen buffers without saving

" -------------------------------------------------------------------
" With Git who needs backup files?
" -------------------------------------------------------------------
set nobackup
set noswapfile

" -------------------------------------------------------------------
" Set the color scheme
" -------------------------------------------------------------------
syntax on
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

" -------------------------------------------------------------------
" Set tab stuff
" -------------------------------------------------------------------
set tabstop=2           " 2 spaces for a tab
set shiftwidth=2        " 2 spaces for autoindenting
set softtabstop=2       " when <BS>, pretend a tab is removed even if spaces
set expandtab           " expand tabs to spaces (overloadable by file type)

" -------------------------------------------------------------------
" Scrolling
" -------------------------------------------------------------------
set scrolloff=5         " show context above/below cursor line
set sidescrolloff=10    " number of cols from horizontal edge to  start scrolling
set sidescroll=1        " number of cols to scroll at a time

" -------------------------------------------------------------------
" Miscellaneous
" -------------------------------------------------------------------
" toggle listchars on or off
noremap <Leader>i :set list!<CR>

" Paste mode to prevent autoindentation of pasted lines
set pastetoggle=<F2>

set clipboard=unnamed   " yank and paste with the system clipboard

" show cursorline only in active window
if has("autocmd")
  autocmd WinLeave * set nocursorline
  autocmd WinEnter * set cursorline
endif

" Map escape to jj -- much faster to reach and type
imap jj <esc>

" -------------------------------------------------------------------
" Searching
" -------------------------------------------------------------------
set incsearch           " use incremental search
set hlsearch            " highlight search results
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search string is all lower case, case-sensitve otherwise
" remove search highlighting with <F3>
nnoremap <silent> <leader>/ :nohlsearch<CR>

" -------------------------------------------------------------------
" Preserve function: saves search history and cursor position
" call with some command, like removing all whitespace
" -------------------------------------------------------------------
function! Preserve(command)
  " preparation: save last search, and cursor position
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business
  execute a:command
  " clean up: restore previous search history and cursor position
  let @/=_s
  call cursor(l,c)
endfunction

" strip whitespace from all lines in file
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" reindent entire file
nmap _= :call Preserve("normal gg=G")<CR>

" -------------------------------------------------------------------
" Splits
" -------------------------------------------------------------------
nnoremap <leader>v <C-w>v<C-w>l   " open a vertical split and switch to it (,v)
nnoremap <leader>h <C-w>s<C-w>j   " open a horizontal split and switch to it (,h)

" -------------------------------------------------------------------
" vimrc shortcuts
" -------------------------------------------------------------------
" open vimrc in new tab for editing
nmap <leader>ev :tabedit $MYVIMRC<cr>

" automatically source .vimrc when it is saved (from vimcasts.org #24)
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif

" reload .vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" -------------------------------------------------------------------
" Command line completion
" -------------------------------------------------------------------
"set wildmode                 " navigate <left> & <right> through completion lists
"set wildmode=list:longest    " allows expansion of items

" -------------------------------------------------------------------
" control whitespace preferences based on filetype
" -------------------------------------------------------------------
if has("autocmd")
  " enable file type detection
  filetype on

  " syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

  " spell check Git commit messages
  autocmd BufRead COMMIT_EDITMSG setlocal spell spelllang=en_us

  " start commit message in insert mode
  autocmd BufNewFile,BufRead COMMIT_EDITMSG call feedkeys('ggi', 't')

  " markdown files
  autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown setfiletype markdown
  autocmd BufNewFile,BufRead *.md,*.mkd,*.markdown set spell spelllang=en_us
  autocmd FileType markdown setlocal tw=100

  " non ruby files related to Ruby
  autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby
  autocmd BufNewFile,BufRead Thorfile,config.ru,Vagrantfile setfiletype ruby
  autocmd BufNewFile,BufRead Berksfile,Berksfile.lock setfiletype ruby
  autocmd BufNewFile,BufRead Rakefile setfiletype rake
  autocmd BufNewFile,BufRead Rakefile set syntax=ruby
  autocmd BufNewFile,BufRead *.rake setfiletype rake
  autocmd BufNEwFile,BufRead *.rake set syntax=ruby

  " Python files
  let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
  autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab

endif

" -------------------------------------------------------------------
" Stuff for Bundles
" -------------------------------------------------------------------
" NERDTree
nmap <leader>T :NERDTreeToggle <CR>
nmap <leader>F :NERDTreeFind <CR>

" show hidden files in NERDTree
let NERDTreeShowHidden=1


" vim-airline settings
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline_theme='solarized'

" Vimux settings
let g:VimuxHeight = "30"
let g:VimuxOrientation = "v"
let g:VimuxUseNearestPane = 0

" custom keymaps
nnoremap <leader><leader> <esc>:xa<CR>
nnoremap <leader>< <esc>:q!
nnoremap <leader> <esc>:wq!

" Opens file to cwd
set browsedir=buffer











call vundle#end()            " required
filetype plugin indent on    " required
