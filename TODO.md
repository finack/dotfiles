
## Setup a new mac
ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)
brew update

brew install postgres --no-python
initdb /usr/local/var/postgres -E utf8

brew install redis

brew install the_silver_searcher

brew install ctags

brew install qt --HEAD

brew install rbenv

eval "$(rbenv init -)"

brew install ruby-build

brew install openssl

rbenv install 2.0.0-p247

rbenv global 2.0.0-p247
rbenv rehash

gem update --system

gem install bundler --no-document --pre

number_of_cores=`sysctl -n hw.ncpu`
bundle config --global jobs `expr $number_of_cores - 1`

curl http://hub.github.com/standalone -sLo ~/.bin/hub
chmod +x ~/.bin/hub

brew install heroku-toolbelt


