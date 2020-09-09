set nocompatible
set t_Co=256

filetype off

set rtp+=${HOME}/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-syntastic/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Bundle 'vim-scripts/HTML-AutoCloseTag'
Bundle 'vim-scripts/c.vim'
Bundle 'rhysd/vim-crystal'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'davidhalter/jedi-vim'
""Bundle 'klen/python-mode'
"""  TypeScript/ES
Bundle 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'dense-analysis/ale'
Plugin 'ycm-core/YouCompleteMe'


" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

call vundle#end()

filetype plugin indent on
syntax on

" set leader key to comma
:let mapleader = ","

" time out mappings after 1s
set timeout timeoutlen=1000 ttimeoutlen=500

" --------------------
" Python Formatting
" --------------------
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
"set laststatus=2 " Always display the statusline in all windows
"set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set tabstop=8
set shiftwidth=4
set expandtab
set shiftwidth=4
set modeline
set softtabstop=4       " when <BS>, pretend a tab is removed even if spaces
autocmd FileType python map <buffer> <F3> :call Flake8()<CR>

" --------------------
" basic options
" ---------------------
set cmdheight=2                   " and use a two-line tall status line
set showcmd                       " show the command
"set autoindent                    " turns it on
set smartindent                   " does the right thing (mostly) in programs
set linespace=2                   " prefer a slight higher line height
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
set history=10000
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


set termencoding=utf-8  " we like utf-8
set encoding=utf-8
set autowrite           " write out old file when switching between files
set autoread            " reload files changed on disk, i.e. via `git checkout`
au FocusLost * :wa      " save file when Vim loses focus
set hidden              " switch beteen buffers without saving
set nobackup
set noswapfile

" -------------------------
" Set the color scheme
" --------------------------
syntax on
let g:solarized_termcolors=256
set background=dark
colorscheme solarized


" -------------------------
" Scrolling
" -------------------------
set scrolloff=5         " show context above/below cursor line
set sidescrolloff=10    " number of cols from horizontal edge to  start scrolling
set sidescroll=1        " number of cols to scroll at a time

" ------------------------
" Searching
" -------------------------
set incsearch           " use incremental search
set hlsearch            " highlight search results
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search string is all lower case, case-sensitve otherwise
" remove search highlighting with <F3>
nnoremap <silent> <leader>/ :nohlsearch<CR>


" --------------------
" Splits
" ---------------------
nnoremap <leader>v <C-w>v<C-w>l   " open a vertical split and switch to it (,v)
nnoremap <leader>h <C-w>s<C-w>j   " open a horizontal split and switch to it (,h)

" --------------------
" Shortcuts
" --------------------
" open vimrc in new tab for editing
nmap <leader>ev :tabedit $MYVIMRC<cr>

" automatically source .vimrc when it is saved (from vimcasts.org #24)
if has("autocmd")
  autocmd! bufwritepost .vimrc source $MYVIMRC
endif

" reload .vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" ------------------
" Completion
" -------------------
"set wildmode                 " navigate <left> & <right> through completion lists
"set wildmode=list:longest    " allows expansion of items

" "  Whitespace
autocmd FileType py setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType js setlocal ts=4 sw=4 sts=0 expandtab
autocmd FileType ruby setlocal ts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sw=2 expandtab

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
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufRead *.md set spell spelllang=en_us
autocmd FileType markdown setlocal tw=100

" non ruby files related to Ruby
autocmd BufNewFile,BufRead Gemfile,Gemfile.lock,Guardfile setfiletype ruby
autocmd BufNewFile,BufRead Thorfile,config.ru,Vagrantfile setfiletype ruby
autocmd BufNewFile,BufRead Berksfile,Berksfile.lock setfiletype ruby
autocmd BufNewFile,BufRead Rakefile setfiletype rake
autocmd BufNewFile,BufRead Rakefile set syntax=ruby
autocmd BufNewFile,BufRead *.rake setfiletype rake
autocmd BufNEwFile,BufRead *.rake set syntax=ruby


""""""""""""""""""""
" => Python
""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def


let NERDTreeIgnore = ['\.pyc$', '\~$', '\.rbc$']
autocmd BufNewFile,BufRead *.py set ts=2 sts=2 sw=2 expandtab

""""""""""""""""""""
" => JavaScript
""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>

au FileType javascript inoremap <buffer> $r return

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
" ----------------------------------------
" Bundles
" ----------------------------------------
" NERDTree
nmap <leader>T :NERDTreeToggle <CR>
nmap <leader>F :NERDTreeFind <CR>
" show hidden
let NERDTreeShowHidden=1

" vim-airline settings
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#trailing_format = 'trailing[%s]'
let g:airline#extensions#whitespace#mixed_indent_format = 'mixed-indent[%s]'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline_theme='papercolor'


"
" NSE
au BufRead,BufNewFile *.nse              set filetype=lua

" ----------------------------------------
"  Keymaps
" ----------------------------------------

" ------------------------
" Nav/Movement
" -------------------------
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

" custom keymaps
nnoremap <leader><leader> <esc>:xa<CR>
nnoremap <leader>< <esc>:q!
nnoremap <leader> <esc>:wq!

" Opens file to cwd
set browsedir=buffer

" ----------------------------------------
"  Misc
" ----------------------------------------
" strip whitespace from all lines in file
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" reindent entire file
nmap _= :call Preserve("normal gg=G")<CR>

" Preserve function:-
" " saves search history, position, etc

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

" toggle listchars on or off
noremap <Leader>i :set list!<CR>

" Paste mode to prevent autoindentation of pasted lines
set pastetoggle=<C-v>

set clipboard=unnamed   " yank and paste with the system clipboard


highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" ----------------------------------------
" Syntastic
"  ----------------------------------------
let g:syntastic_python_python_exec = '/Library/Frameworks/Python.framework/Versions/3.4/bin/python3'

let g:syntastic_python_checkers = ['pylint']

let g:pymode_options = 1
" python-mode doc key:
let g:pymode_doc_bind = 'K'
" virtualenv auto-detect
let g:pymode_virtualenv = 1
" virtualenv manual-detect
let g:pymode_virtualenv_path = $VIRTUAL_ENV

