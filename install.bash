#!/bin/bash

git submodule init
git submodule update

rm -rf ~/.oh-my-zsh
$(pwd)/dotfiles/oh-my-zsh/tools/install.sh &
mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

sleep 2

cp -a dotfiles/.oh-my-zsh/custom/matt-eastwood.zsh-theme ~/.oh-my-zsh/themes

echo "Backing up current configs ... "
mkdir -p ~/.backup

for file in $(pwd)/dotfiles/.*; do
  basefile=$(basename $file)

  # skip . and .. , they're special
  if [[ $basefile == '.'
     || $basefile == '..'
     ]]; then
     continue
  fi

  # just remove symlinks
  if [[ -L ~/$basefile ]]; then
    rm -f ~/$basefile
  else
    # back up current dotfiles
    mv -U ~/$basefile ~/.backup/ 2>/dev/null
  fi

  echo "Installing $basefile"
  rsync -a $file ~/$basefile
done

for file in $(pwd)/dotfiles/*; do
  basefile=$(basename $file)

  # just remove symlinks
  if [[ -L ~/$basfile ]]; then
    rm -f ~/$basefile
  else
    # back up current dotfiles
    mv -U ~/$basefile ~/.backup/ 2>/dev/null
  fi

  echo "Installing $basefile"
  rsync -a $file ~/$basefile
done
