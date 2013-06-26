#!/bin/bash

# CDE specific aliases
alias cde='cd ~/Projects/Corndog'
alias config='cd ~/config'

# Git aliases
alias gs='git status'
alias gc='git checkout'
alias gb='git branch'
alias gl='git log'

# shortcut to vim
alias :e=vim

# sooo many letters to type in a day, here's a few less for the history command
alias h='history'

# Add an "alert" alias for long running commands. Use semicolor to execute it in sequence
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# replace this with a util that allows real directory history navigation
alias cx='pushd'
alias cz='popd'

alias be='bundle exec'

alias testify='git pull --rebase && bundle && bundle exec rake && cd data && bundle && bundle exec rspec && cd .. && echo "All tests passed" && alert "All tests passed" || alert "Something failed"'
alias jaz="phantomjs spec/javascripts/runner.coffee http://localhost:5555/jasmine | grep -h -B3 -A1 '\(failures\|\"passed\": false\|messages\)'"
