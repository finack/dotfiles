#!/bin/sh

## Originally from https://github.com/thoughtbot/laptop/blob/master/mac
fancy_echo() {
	local fmt="$1"; shift

	# shellcheck disable=SC2059
	printf "\\n$fmt\\n" "$@"
}

# shellcheck disable=SC2154
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT

set -e

update_shell() {
	local shell_path;
	shell_path="$(command -v zsh)"

	fancy_echo "Changing your shell to zsh ..."
	if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
		fancy_echo "Adding '$shell_path' to /etc/shells"
		sudo sh -c "echo $shell_path >> /etc/shells"
	fi
	sudo chsh -s "$shell_path" "$USER"
}

case "$SHELL" in
	*/zsh)
		if [ "$(command -v zsh)" != '/usr/local/bin/zsh' ] ; then
			update_shell
		fi
		;;
	*)
		update_shell
		;;
esac

gem_install_or_update() {
	if gem list "$1" --installed > /dev/null; then
		gem update "$@"
	else
		gem install "$@"
	fi
}

if ! command -v brew >/dev/null; then
	fancy_echo "Installing Homebrew ..."
		curl -fsS \
			'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

		export PATH="/usr/local/bin:$PATH"
fi

if brew list | grep -Fq brew-cask; then
	fancy_echo "Uninstalling old Homebrew-Cask ..."
	brew uninstall --force brew-cask
fi

fancy_echo "Updating Homebrew formulae ..."
brew update --force # https://github.com/Homebrew/brew/issues/1151
brew bundle install
brew bundle --file=- <<EOF
tap "homebrew/services"
tap "universal-ctags/universal-ctags"
tap "homebrew/cask-fonts"

# Unix
brew "coreutils"
brew "openssl"

brew "fzf"
brew "git"
brew "neovim"
brew "rcm"
brew "reattach-to-user-namespace"
brew "the_silver_searcher"
brew "tmux"
brew "universal-ctags", args: ["HEAD"]
brew "ripgrep"
brew "watchman"
brew "zsh"

cask "font-hack-nerd-font"

brew "node"

brew "rbenv"
brew "ruby-build"

brew "python3"
EOF

fancy_echo "Update pip"
pip3 install --upgrade pip

fancy_echo "Update ruby"
ruby_version=3.3

eval "$(rbenv init - zsh)"

if ! rbenv versions | grep -Fq "$ruby_version"; then
  rbenv install -s "$ruby_version"
fi

rbenv global "$ruby_version"
rbenv shell "$ruby_version"
rbenv rehash

gem update --system
gem_install_or_update 'bundler'
gem_install_or_update 'neovim'
gem_install_or_update 'tmuxinator'

fancy_echo "Grab submodules"
git submodule update --init

fancy_echo "Add neovim support"
pip3 install neovim psutil

npm install -g neovim
npm install --global typescript

fancy_echo "Linking rc files"
rcup -v
