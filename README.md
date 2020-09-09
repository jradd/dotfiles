# dotfiles
mostly just vimrc and some zsh functions

### configure vundle
```
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
"Plugin 'tpope/vim-fugitive'
"Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'file:///home/gmarik/path/to/plugin'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

call vundle#end()            " required
filetype plugin indent on    " required
```


```sh
cd $HOME; git clone https://github.com/jradd/dotfiles.git
mv ~/.vimrc ~/_vimrc
ln -s dotfiles/.vimrc
```

### VIm
`:PluginInstall`


### ZSH Functions
`ln -s ~/dotfiles/.zshfunc && source ~/.zshfunc`

#### remove comments and lines
`_decom <file>`

#### autocreate git repo
api key required

#### WANT
ssh-keygen

#### WANT
screen config
tmux config

fortunes, motd, hints


