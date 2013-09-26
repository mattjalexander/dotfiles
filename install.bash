#!/bin/bash

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
    rm ~/$basefile
  else
    # back up current dotfiles
    mv ~/$basefile ~/.backup/
  fi

  ln -s $file ~/$basefile
done

for file in $(pwd)/dotfiles/*; do
  basefile=$(basename $file)

  # just remove symlinks
  if [[ -L ~/$basfile ]]; then
    rm ~/$basefile
  else
    # back up current dotfiles
    mv ~/$basefile ~/.backup/
  fi

  ln -s $file ~/$basefile
done
