#!/bin/bash         

### GET REPOS READY ###

# update & upgrade #
sudo apt-get update
sudo apt-get upgrade


### INSTALL new apps ###

sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion ruby ncurses-term mercurial ruby-dev exuberant-ctags libnotify-bin curl autoconf make automake ssh openjdk-6-jdk git-core git-doc imagemagick postgresql-contrib libpq-dev postgresql pgadmin3 vim vim-rails

### Configure git ###

git config --global user.name <USERNAME>
git config --global user.email <EMAIL>

# Configure SSH key#
# ssh-keygen -t rsa -C <EMAIL>

# Add Key to Github #

### Install RVM - Ruby Version Manager ###

bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bashrc
source .bashrc

rvm get head

# Install Ruby #
rvm install 1.8.7-head
rvm install 1.9.2-head
rvm install 1.9.3-head
rvm --default 1.9.2-head
rvm use default

# Install Rails #
gem install rails vagrant bundler

### Add Sublime Text 2 ###
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text-2

# Add Git Support#
cd ~/.config/sublime-text-2/Packages/
git clone git://github.com/kemayo/sublime-text-2-git.git Git

# MySQL
sudo apt-get install mysql-server libmysqlclient-dev libmysql-ruby


