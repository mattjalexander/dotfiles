# RVM settings
if [[ -s ~/.rvm/scripts/rvm && -n $(~/.rvm/bin/rvm-prompt) ]] ; then
  RPS1="%{$fg[yellow]%}rvm:%{$reset_color%}%{$fg[red]%}\$(~/.rvm/bin/rvm-prompt)%{$reset_color%} $EPS1"
else
  if which rbenv &> /dev/null; then
    RPS1="%{$fg[yellow]%}rbenv:%{$reset_color%}%{$fg[red]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$reset_color%} $EPS1"
  fi
fi




ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%B‽%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# detects host type
prompt_host() {
  if [[ $(uname) == 'Darwin' ]]; then echo "[]"; fi
}

# mostly snagged from agnoster theme
prompt_status() {
  RETVAL=$?
  JOBS=$(jobs -l | wc -l)
  local symbols
  symbols=()

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘ $RETVAL"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $JOBS -gt 0 ]] && symbols+="%{%F{cyan}%}[⚙]"

  echo "$symbols%{$reset_color%}"
}

PROMPT='$(prompt_status)$(prompt_host)$(git_custom_status)%{$fg[cyan]%}[%~% ]%{$reset_color%}%B$%b '
RPS1='$RPS %{$fg_bold[black]%}%T%{$reset_color%}'
