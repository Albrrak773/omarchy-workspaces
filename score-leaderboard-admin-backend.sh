#!/bin/bash
# Workspace: Score Leaderboard Admin Backend
# Launches the admin backend development environment

PROJECT="/run/media/albrrak773/colorful SSD/Rclone/code/projects/Score Tracker/score-leaderboard-Admin-app/Backend/"

notify-send "Launching Workspace" "Score Leaderboard Admin Backend" -t 2000

uwsm-app -- xdg-terminal-exec --title="./run.sh" --dir="$PROJECT" -e bash -i -c "./run.sh; exec bash" &
uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit &
uwsm-app -- code "$PROJECT" &
omarchy-launch-webapp "http://localhost:7001/docs" &
