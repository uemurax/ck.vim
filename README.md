ck.vim
======

A fork of [vim-scripts/ck.vim](https://github.com/vim-scripts/ck.vim),
a syntax file for the [ChucK Audio Programming Language](http://chuck.cs.princeton.edu/),
in wich I added
ftdetect and ftplugin subdirectories
and fixed syntax.


## Installation

### Using [pathogen](https://github.com/tpope/vim-pathogen)

    cd ~/.vim/bundle
    git clone https://github.com/uemurax/ck.vim

### Using [NeoBundle](https://github.com/Shougo/neobundle.vim)

Add the following line to your .vimrc file

    NeoBundle 'uemurax/ck.vim'

Launch `vim` and run `:NeoBundleInstall`.

## Commands and keymaps

- `:Host {hostname}` set the host where to send on-the-fly commands
  (default host is `localhost`)
- `:Host` show hostname
- `:Remove {shred IDs}` remove shreds
- `:Replace {shread ID}` replace existing shred with current file
- `<LocalLeader>+` add current file
- `<LocalLeader>^` show status
- `<LocalLeader>t` show time
- `<LocalLeader>k` kill ChucK
- `<LocalLeader>h` show hostname

