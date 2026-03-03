#!/bin/bash
# Workspace: Send Certificates
# Launches the send-certificates development environment

PROJECT="/run/media/albrrak773/colorful SSD/Rclone/code/projects/Score Tracker/send-certificates"
notify-send "Launching Workspace" "Send Certificates" -t 2000

uwsm-app -- code "$PROJECT" &
omarchy-launch-webapp "http://localhost:8000/docs" &
uwsm-app -- xdg-terminal-exec --title="fastapi dev" --dir="$PROJECT" -e bash -i -c "source .venv/bin/activate && fastapi dev; exec bash" &
uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit &
