#!/bin/bash
# Start both daemons in a tmux session

. shared.sh

tmux new-session -d -s runv-standalone './runv.sh'
tmux rename-window 'runv environment'
tmux split-window -h './docker-daemon.sh'
tmux set-option -g -t runv-standalone mouse on
tmux -2 attach-session -t runv-standalone
