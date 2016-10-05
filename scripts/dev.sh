#!/bin/sh

alias tmux="tmux -2"

# attach to it if possible
tmux attach-session -t 'dev' && exit $?

# create it otherwise
cd ~/projects/$1
tmux new-session -d -s 'dev' -n 'src'
tmux split-window -v -p 30
tmux new-window -n 'sh'
tmux split-window -v
tmux select-window -t 1
tmux select-pane -t 1
tmux attach-session -t 'dev'
