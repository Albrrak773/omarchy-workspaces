#!/bin/bash
# Workspace: Oracle2
# Connects to oracle2 server

notify-send "Launching Workspace" "Oracle2" -t 2000

uwsm-app -- xdg-terminal-exec --title="pm2 monit" -e bash -i -c "TERM=xterm-256color ssh -t oracle2 \"/home/ubuntu/.nvm/versions/node/v24.12.0/bin/pm2 monit\"; exec bash" &
uwsm-app -- ghostty --font-size=10 -e bash -i -c "TERM=xterm-256color ssh -t oracle2 \"btop\"; exec bash" &
uwsm-app -- xdg-terminal-exec --title="oracle2 ssh" -e bash -i -c "TERM=xterm-256color ssh oracle2; exec bash" &
uwsm-app -- nautilus "sftp://oracle2/home/ubuntu" &
