# Omarchy Workspaces

Custom development environment launcher for [Omarchy](https://omarchy.org/) Linux.

Define workspace scripts that launch multiple windows (terminals, editors, browsers) with a single click from the Omarchy menu.
### Demo
![screenrecording-2026-02-27_11-37-14-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/e1f04321-d1f7-4bc7-9042-ec9204b6868f)

*this opens Chrome with 2 tabs Discord and Jellyfin and it opens a Notion web app at a predifened page and finally Spotify*
## Features

- Launch multiple apps/windows with one menu selection
- Custom terminal titles (shows "pnpm dev" instead of "Ghostty" in window groups)
- Terminals stay open after processes exit
- Automatic discovery of workspace scripts
- Works with mise for environment management

## Installation

### 1. Create the workspaces directory

```bash
mkdir -p ~/.config/omarchy/workspaces
```

### 2. Install the menu extension

```bash
mkdir -p ~/.config/omarchy/extensions
curl -o ~/.config/omarchy/extensions/menu.sh https://raw.githubusercontent.com/Albrrak773/omarchy-workspaces/main/extensions/menu.sh
chmod +x ~/.config/omarchy/extensions/menu.sh
```

### 3. Add workspace scripts

Create executable `.sh` files in `~/.config/omarchy/workspaces/`:

```bash
touch ~/.config/omarchy/workspaces/my-project.sh
chmod +x ~/.config/omarchy/workspaces/my-project.sh
```

### 4. Use it

1. Open Omarchy menu (Super + Space)
2. Select **Workspaces**
3. Choose your environment

## Writing Workspace Scripts

### Basic Template

```bash
#!/bin/bash
# Workspace: My Project

PROJECT="$HOME/code/my-project"

notify-send "Launching Workspace" "My Project" -t 2000

# Terminal with dev server
uwsm-app -- xdg-terminal-exec --title="pnpm dev" --dir="$PROJECT" -e bash -i -c "mise exec -- pnpm dev; exec bash" &

# VS Code
uwsm-app -- code "$PROJECT" &

# Browser
omarchy-launch-webapp "http://localhost:3000" &

# Lazygit
uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit &
```

### Naming Convention

- Filenames use kebab-case: `my-awesome-project.sh`
- Display names use Title Case: `My Awesome Project"
- Dashes become spaces in the menu

## Useful Commands

| Task | Command |
|------|---------|
| Terminal in directory | `uwsm-app -- xdg-terminal-exec --dir="$PROJECT"` |
| Terminal with title and command | `uwsm-app -- xdg-terminal-exec --title="name" --dir="$PROJECT" -e bash -i -c "command; exec bash"` |
| Terminal with lazygit | `uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit` |
| VS Code | `uwsm-app -- code "$PROJECT"` |
| Web app (chromium) | `omarchy-launch-webapp "https://example.com"` |
| Chrome with tabs | `uwsm-app -- google-chrome-stable --new-window "url1" "url2"` |
| Notification | `notify-send "Title" "Message" -t 2000` |

## Tips

- Use `--title="name"` to set terminal titles (helpful for window grouping in Hyprland)
- Use `mise exec --` before commands that need mise-managed tools (node, pnpm, python, etc.)
- The `-i` flag on bash makes it interactive, which helps with PATH/environment
- Add `; exec bash` at the end of commands to keep the terminal open after the process exits
- All apps launch simultaneously (no need for `sleep` between them)
- Keep projects as variables at the top for easy modification

## Example Templates

### Frontend with pnpm

```bash
#!/bin/bash
PROJECT="$HOME/code/frontend-app"

notify-send "Launching Workspace" "Frontend App" -t 2000

uwsm-app -- xdg-terminal-exec --title="pnpm dev" --dir="$PROJECT" -e bash -i -c "mise exec -- pnpm dev; exec bash" &
uwsm-app -- code "$PROJECT" &
uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit &
omarchy-launch-webapp "http://localhost:3000" &
```

### Python with FastAPI

```bash
#!/bin/bash
PROJECT="$HOME/code/api"

notify-send "Launching Workspace" "API" -t 2000

uwsm-app -- xdg-terminal-exec --title="fastapi dev" --dir="$PROJECT" -e bash -i -c "source .venv/bin/activate && fastapi dev; exec bash" &
uwsm-app -- code "$PROJECT" &
uwsm-app -- xdg-terminal-exec --title="lazygit" --dir="$PROJECT" -e lazygit &
omarchy-launch-webapp "http://localhost:8000/docs" &
```

### Side Utilities

```bash
#!/bin/bash
notify-send "Launching Workspace" "Side Utils" -t 2000

uwsm-app -- google-chrome-stable --new-window "https://discord.com/app" &
omarchy-launch-webapp "https://notion.so" &
uwsm-app -- spotify &
```

## How It Works

The `menu.sh` extension hooks into Omarchy's menu system:

1. Adds a `show_workspaces_menu()` function that scans `~/.config/omarchy/workspaces/` for executable `.sh` files
2. Overrides `show_main_menu()` to include a "Workspaces" option
3. Overrides `go_to_menu()` to handle the workspaces case

When selected, it runs the workspace script which launches all your apps in parallel.

## My Workspaces

This repo includes my personal workspace scripts:

- `score-leaderboard-admin-frontend.sh` - Frontend dev with pnpm
- `send-certificates.sh` - Python FastAPI project
- `side-utils.sh` - Discord, Notion, Spotify

## Requirements

- [Omarchy](https://omarchy.org/) Linux distribution
- Hyprland window manager
- Ghostty or other terminal supporting `xdg-terminal-exec`
- mise (optional, for managing dev tools)
