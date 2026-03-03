#!/bin/bash
# Workspace: Score Leaderboard App
# Launches the score-leaderboard-app development environment

PROJECT="/run/media/albrrak773/colorful SSD/Rclone/code/projects/Score Tracker/score-leaderboard-app"

notify-send "Launching Workspace" "Score Leaderboard App" -t 2000

uwsm-app -- xdg-terminal-exec --title="opencode" --dir="$PROJECT" -e bash -i -c "mise exec -- opencode; exec bash" &
uwsm-app -- xdg-terminal-exec --title="pnpm dev" --dir="$PROJECT" -e bash -i -c "mise exec -- pnpm dev -p 3000; exec bash" &
uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit &
uwsm-app -- code "$PROJECT" &
omarchy-launch-webapp "http://localhost:3000" &
