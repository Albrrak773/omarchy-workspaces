#!/bin/bash
# Workspace: Side Utils
# Launches side utilities (Discord, Jellyfin, Notion, Spotify)

notify-send "Launching Workspace" "Side Utils" -t 2000

uwsm-app -- google-chrome-stable --new-window "https://discord.com/app" "http://localhost:8096" &
omarchy-launch-webapp "https://www.notion.so/The-Event-Loop-2f98fdd5c8d780ed849ce68206994be6" &
uwsm-app -- spotify &
