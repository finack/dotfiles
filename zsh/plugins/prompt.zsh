# makes color constants available
autoload -U colors && colors

# enable colored output from ls, etc
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# BASE16_SCHEME="tomorrow"
# BASE16_SHELL="$HOME/.themes/base16-shell/base16-$BASE16_SCHEME.dark.sh"
# [[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# Base16 Shell
BASE16_SHELL="$HOME/.dotfiles/themes/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

#expand functions in the prompt
setopt prompt_subst

#https://github.com/olivierverdier/zsh-git-prompt
source ~/.zsh/zsh-git-prompt/zshrc.sh

# expand functions in the prompt
setopt prompt_subst

# prompt
local ssh_prompt="%F{064}%n@%m%f:"
local MODE_INDICATOR="%F{136}-%fvi-cmd%F{136}-%f"

# Set path to red if return code is not 0
export PROMPT="${SSH_CONNECTION+${ssh_prompt}}%(?,%F{136},%F{160})%~%f "
export RPROMPT='$(git_super_status)'

function zle-line-init {
  zle reset-prompt
}
function zle-line-init zle-keymap-select {
  export RPROMPT="${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/$(git_super_status)}"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
