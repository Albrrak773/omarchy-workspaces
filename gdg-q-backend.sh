#!/bin/bash
# Workspace: GDG-Q Backend
# Launches the GDG-Qassim backend development environment

PROJECT="/run/media/albrrak773/colorful SSD/Rclone/code/projects/GDG-Qassim/gdg-qassim-backend"

notify-send "Launching Workspace" "GDG-Q Backend" -t 2000

uwsm-app -- xdg-terminal-exec --title="uv run poe dev" --dir="$PROJECT" -e bash -i -c "uv run poe dev; exec bash" &
uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit &
uwsm-app -- xdg-terminal-exec --title="opencode" --dir="$PROJECT" -e opencode &
uwsm-app -- google-chrome-stable --new-window "http://localhost:8000/docs" &
uwsm-app -- code "$PROJECT" &