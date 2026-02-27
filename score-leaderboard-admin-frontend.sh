#!/bin/bash
# Workspace: Score Leaderboard Admin Frontend
# Launches the frontend development environment

PROJECT="/run/media/albrrak773/colorful SSD/Rclone/code/projects/Score Tracker/score-leaderboard-Admin-app/Frontend/"

notify-send "Launching Workspace" "Score Leaderboard Admin Frontend" -t 2000

uwsm-app -- xdg-terminal-exec --title="pnpm dev" --dir="$PROJECT" -e bash -i -c "mise exec -- pnpm dev; exec bash" &
uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit &
uwsm-app -- code "$PROJECT" &
omarchy-launch-webapp "http://localhost:3000" &
