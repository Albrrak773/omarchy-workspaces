# AGENTS.md

## What This Repo Is

Omarchy Workspaces — a collection of executable `.sh` scripts and a menu extension that adds a "Workspaces" submenu to Omarchy's launcher. Each script launches a preset set of terminals, editors, and browsers for a specific project.

## Key Conventions

- **Workspace scripts live at repo root**, named in kebab-case (e.g. `side-utils.sh`). The menu converts dashes to spaces and Title Cases them for display.
- **Scripts must be executable** (`chmod +x`). The menu only discovers files that are both `.sh` and executable.
- **`# Workspace: Display Name`** comment at the top of each script is the human-readable label (not used by menu — display name is derived from filename).
- **All commands run inside `uwsm-app --`**. This is required for Hyprland integration; omitting it breaks window management.
- **Use `mise exec --` before any command** that needs mise-managed tools (node, pnpm, python, etc.).
- **Use `bash -i -c "command; exec bash"`** for terminal commands to keep shells interactive after the process exits.
- **Use `omarchy-launch-webapp`** for web apps (Chromium-based PWA window) and `google-chrome-stable --new-window` for multi-tab Chrome windows.

## The Menu Extension

`extensions/menu.sh` overrides two Omarchy menu functions (`show_main_menu`, `go_to_menu`) and adds `show_workspaces_menu`. It scans `~/.config/omarchy/workspaces/*.sh` at runtime.

## Adding a New Workspace

1. Create an executable `.sh` file at repo root (kebab-case name).
2. Set `PROJECT=` variable at top if the workspace targets a specific directory.
3. Start with `notify-send` for user feedback.
4. Launch apps with `uwsm-app --` and `&` (all in parallel, no `sleep` needed).
5. Update `README.md` "My Workspaces" section to list it.

## File Ownership

- `*.sh` (root) — personal workspace scripts
- `extensions/menu.sh` — Omarchy menu integration (shared, applies to all users)
- `README.md` — user-facing docs and template reference