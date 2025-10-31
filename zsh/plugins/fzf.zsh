# Setup fzf key bindings and fuzzy completion
# Using eval instead of source to ensure it works in non-interactive shells
eval "$(fzf --zsh)"

# FZF Options
# -----------
export FZF_DEFAULT_OPTS='
  --height 40% 
  --layout=reverse 
  --border
  --inline-info
  --bind="ctrl-y:execute-silent(echo {} | pbcopy)"
'

# Better history search (Ctrl+R) with preview
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window down:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command, CTRL-/ to toggle preview'
"

# Better file search (Ctrl+T)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {} 2>/dev/null || cat {} 2>/dev/null || ls -la {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

# Better directory navigation (Alt+C)
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"

# Use fd instead of find if available (faster)
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi
