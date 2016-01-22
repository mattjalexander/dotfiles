# right hand prompt:
RPS1="%{$fg_bold[black]%}%T%{$reset_color%}"
# RVM/rbenv if they exist and date
#if [[ -s ~/.rvm/scripts/rvm && $(~/.rvm/bin/rvm-prompt) != '' ]] ; then
#  RPS1="%{$fg[yellow]%}💎 :%{$reset_color%}%{$fg[red]%}\$(~/.rvm/bin/rvm-prompt)%{$reset_color%} $RPS1 $EPS1"
#else
#  if which rbenv &> /dev/null; then
#    RPS1="%{$fg[yellow]%}💎 :%{$reset_color%}%{$fg[red]%}\$(rbenv version | sed -e 's/ (set.*$//')%{$reset_color%} $RPS1 $EPS1"
#  fi
#fi

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
  RETVAL=$?
  if [[ $RETVAL -eq 0 ]]; then                                          # ┬─┬ノ(º_ºノ)
    if [[ $(uname) == 'Darwin' ]]; then
        echo ""
    elif [[ $(hostname | cut -d\. -f2) == "desktop" ]]; then
        echo "🚪 "
    elif [[ -n $(hostname | grep ^dev-dsk) ]]; then
        echo "%{$fg_bold[yellow]%}⚡%{$reset_color%}"
    else
        echo "?"
    fi
  else                                                                  # (╯°□°）╯︵ ┻━┻
    echo "%{$fg[red]%}✘ $RETVAL%{$reset_color%} "
  fi

}

# mostly snagged from agnoster theme
prompt_status() {
  myjobs=$(jobs -l | wc -l | awk '{print $1}')

  [[ $myjobs -gt 0 ]] && symbols+="%{%F{cyan}%}(⚙ $myjobs)"
  [[ $UID -eq 0 ]]  && symbols+="%{%F{yellow}%}⚡"
  echo "$symbols%{$reset_color%}"

}

PROMPT='$(prompt_host)$(git_custom_status)%{$fg[blue]%}[%~% ]$(prompt_status)%{$reset_color%}%B$%b '
