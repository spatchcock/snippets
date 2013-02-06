#!/bin/bash         

### GET REPOS READY ###

# update & upgrade #
sudo apt-get update
sudo apt-get upgrade


### INSTALL new apps ###

sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion ruby ncurses-term mercurial ruby-dev exuberant-ctags libnotify-bin curl autoconf make automake ssh openjdk-6-jdk git-core git-doc imagemagick postgresql-contrib libpq-dev postgresql pgadmin3 vim vim-rails

### Configure git ###

git config --global user.name spatchcock
git config --global user.email andrew.berkeley.is@googlemail.com

# Configure SSH key#
ssh-keygen -t rsa -C andrew.berkeley.is@googlemail.com

# Add Key to Github #

### Install RVM - Ruby Version Manager ###

\curl -L https://get.rvm.io | bash -s stable
source .bash_profile

# https://rvm.io/integration/gnome-terminal/
# "For RVM to work properly, you have to set the 'Run command as login shell' checkbox on the Title and Command tab inside of gnome-terminal's Settings page"

rvm get head

# Install Ruby #
rvm install 1.8.6-p420
rvm install 1.8.7-head
rvm install 1.9.2-head
rvm install 1.9.3-p194
rvm --default 1.9.3-p194
rvm use default

# Install Rails #
sudo gem install rails bundler

### Add Sublime Text 2 ###
sudo add-apt-repository ppa:webupd8team/sublime-text-2
sudo apt-get update
sudo apt-get install sublime-text

# Add Git Support#
cd ~/.config/sublime-text-2/Packages/
git clone git://github.com/kemayo/sublime-text-2-git.git Git

# MySQL
sudo apt-get install mysql-server libmysqlclient-dev libmysql-ruby

# Install Oracle Virtual Box
# Dependencies
sudo apt-get install bcc iasl xsltproc xalan libxalan110-dev uuid-dev zlib1g-dev libidl-dev libsdl1.2-dev libxcursor-dev libqt3-headers libqt3-mt-dev libasound2-dev libstdc++5 linux-headers-`uname -r` build-essential

# Just install Oracle Virtual Box using Synaptic...

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable
