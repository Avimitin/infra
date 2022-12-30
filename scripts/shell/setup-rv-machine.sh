#!/bin/bash

prefix="https://raw.githubusercontent.com"

declare -A resources
resources=(
  ["$HOME/.vimrc"]="Avimitin/Avimitin/master/.vimrc"
  ["$HOME/.bashrc"]="Avimitin/Avimitin/master/.bashrc"
  ["$HOME/.tmux.conf"]="Avimitin/tmux/master/.tmux.conf.min"
)

for output in ${!resources[@]}; do
  remote="${prefix}/${resources[$output]}"
  echo "Downloaing $remote to $output"

  curl -sSfLo "$output" "$remote"
done
