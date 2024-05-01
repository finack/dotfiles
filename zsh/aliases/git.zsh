alias g="git"
alias ga='git add'
alias gap='ga -p'
alias gau='git add -u'
alias gbr='git branch -v'
gc() {
  git diff --cached | grep '\btap[ph]\b' >/dev/null &&
    echo "\e[0;31;29mOops, there's a #tapp or similar in that diff.\e[0m" ||
    git commit -v "$@"
}
alias gc!='git commit -v'
alias gca='git commit -v -a'
alias gcam='gca --amend'
alias gch='git cherry-pick'
alias gcm='git commit -v --amend'
alias gwip='git commit -v -a -m "wip"'
alias gco='git checkout'
gcop() {
  git ls-remote --exit-code origin refs/pull/$1/merge
  [ $? -ne 0 ] && echo "Could not find pull request $1" && return
  git fetch origin +refs/pull/$1/merge
  git checkout FETCH_HEAD
}

alias gd='git diff -M'
alias gd.='git diff -M --color-words="."'
alias gdc='git diff --cached -M'
alias gdc.='git diff --cached -M --color-words="."'
alias gf='git fetch'
git-new() {
  [ -d "$1" ] || mkdir "$1" &&
  cd "$1" &&
  git init &&
  touch .gitignore &&
  git add .gitignore &&
  git commit -m "Added .gitignore."
}
alias glog='git log --pretty="format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset"'
alias gl='glog --graph'
alias glol='git log --pretty=oneline --abbrev-commit --graph --decorate'
alias glwip='gl origin/master..origin/develop'
alias gla='gl --all'
alias glp='gl -p'
glg() {
  query="$1"
  shift
  glog "--grep=$query" "$@"
}
glsearch() {
  query="$1"
  shift
  glog --pickaxe-regex "-S$query" "$@"
}
glunpushed() {
  branch=$(git symbolic-ref HEAD | sed 's|refs/heads/||')
  git log origin/$branch..HEAD
}
glunpulled() {
  branch=$(git symbolic-ref HEAD | sed 's|refs/heads/||')
  git fetch && git log HEAD..origin/$branch
}

alias gm='git merge --no-ff'
alias gmf='git merge --ff-only'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpt='gp --tags'
alias gr='git reset'
alias gre='git rebase -p'
alias grec='git rebase --continue'
alias grei='git rebase -i'
alias grh='git reset --hard'
alias grp='gr --patch'
alias grsh='git reset --soft HEAD~'
alias grv='git remote -v'
alias gs='git show'
alias gs.='git show --color-words="."'
alias gst='git status -sb'
alias gss='git stash'
alias gssa='git stash apply'
alias gssp='git stash pop'
alias gup='git smart-pull'
alias graf='git remote add $argv[1] $argv[2] && gf $argv[1]'

git-prune() {
  git fetch --prune
  for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}');
    do git branch -D $branch;
   done
}
alias gfu='git-prune'

# vim ft=sh
