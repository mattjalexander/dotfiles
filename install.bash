#!/bin/bash

git submodule init
git submodule update

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

  cp -a $file ~/$basefile
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

  cp -a $file ~/$basefile
done
