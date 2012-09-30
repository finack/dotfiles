fsproru dotfiles
===================

This is a mix of https://github.com/PeterHBaker/dotfiles and https://github.com/thoughtbot/dotfiles. These also include
with vim configuration lifted from http://github.com/Casecommons/vim-config.

Install
-------

First, [fork this repo](https://github.com/fsproru/dotfiles#fork_box) on Github.

Then, clone your Github fork (replace "your-github-name" with your Github name) onto your laptop and install it:

    git clone git@github.com:your-github-name/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    git submodule update --init
    zsh
    ./install.sh

This will create symlinks for all config files in your home directory. You can
safely run this file multiple times to update.

There is configuration for `zsh` so switch your shell from the default `bash` to `zsh` on OS X:

    chsh -s /bin/zsh

Configure VIM
-------------

Assumes VIM is compiled against your system ruby

    cd ~/.vim/bundle/command-t/ruby/command-t 
    rvm use system 
    ruby extconf.rb 
    make 
    sudo make install 

Why fork?
---------

dotfiles are fairly personal. You should be able to modify your dotfiles, and save them in version control in your fork.

However, the thoughtbot (and finack) folks are often tweaking these dotfiles and you want to be able to get those updates.

So, your master branch is meant for your customizations and use the `upstream` branch to get thoughtbot's updates.

Set up the upstream branch
--------------------------

You only have to do this once:

    git remote add upstream git@github.com:fsproru/dotfiles.git
    git fetch upstream
    git checkout -b upstream upstream/master

Update
------

Each time you want to update:

For example, to customize your `zsh` config, make your changes in `~/.zshenv`:

    # RVM
    [[ -s '/Users/croaky/.rvm/scripts/rvm' ]] && source '/Users/croaky/.rvm/scripts/rvm'

    # recommended by brew doctor
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

Commit those kinds of things in your master branch.

Then, each time you want to update thoughtbot's changes.

    git checkout upstream
    git pull
    git checkout master
    git rebase upstream
    git submodules update --init