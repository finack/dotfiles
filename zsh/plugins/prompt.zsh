# makes color constants available
autoload -U colors && colors

# enable colored output from ls, etc
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx


# Solarized GNU Colors
if [ -e "$HOME/.zsh/dircolors/dircolors.256dark" -a $+commands[dircolors] ]; then
  eval `dircolors $HOME/.zsh/dircolors/dircolors.256dark`
fi

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

## Colors
#SOLARIZED TERMCOL  XTERM
#--------- -------  ----
#base03    brblack  234
#base02    black    235
#base01    brgreen  240
#base00    bryellow 241
#base0     brblue   244
#base1     brcyan   245
#base2     white    254
#base3     brwhite  230
#yellow    yellow   136
#orange    brred    166
#red       red      160
#magenta   magenta  125
#violet    brmagenta 61
#blue      blue      33
#cyan      cyan      37
#green     green     64
