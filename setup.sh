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

if [ ! -d "$HOME/.bin/" ]; then
	mkdir "$HOME/.bin"
fi

if [ ! -f "$HOME/.zshrc" ]; then
	touch "$HOME/.zshrc"
fi

HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
	if ! [ -r "$HOMEBREW_PREFIX" ]; then
		sudo chown -R "$LOGNAME:admin" /usr/local
	fi
else
	sudo mkdir "$HOMEBREW_PREFIX"
	sudo chflags norestricted "$HOMEBREW_PREFIX"
	sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

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

fancy_echo "Update pip"
pip3 install --upgrade pip

fancy_echo "Grab submodules"
git submodule update --init

fancy_echo "Add neovim support"
pip3 install neovim psutil
npm install -g neovim

npm install --global typescript

mkdir -p ~/.local/share/nvim/plugged
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

fancy_echo "Linking rc files"
rcup -v
