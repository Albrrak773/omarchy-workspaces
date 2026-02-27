#!/bin/bash
# Omarchy Menu Extension: Workspaces
# Adds a "Workspaces" submenu to launch custom development environments

show_workspaces_menu() {
  local workspaces_dir="$HOME/.config/omarchy/workspaces"
  local options=""
  
  if [[ -d "$workspaces_dir" ]]; then
    for script in "$workspaces_dir"/*.sh; do
      if [[ -f "$script" && -x "$script" ]]; then
        local name=$(basename "$script" .sh)
        local display=$(echo "$name" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
        options="${options}${display}\n"
      fi
    done
  fi
  
  options=$(echo -e "$options" | sed '/^$/d')
  
  if [[ -z "$options" ]]; then
    notify-send "No workspaces configured" "Add executable .sh scripts to ~/.config/omarchy/workspaces/"
    back_to show_main_menu
    return
  fi
  
  local choice=$(menu "Workspaces" "$options")
  
  if [[ -n "$choice" && "$choice" != "CNCLD" ]]; then
    local script_name=$(echo "$choice" | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')
    local script_path="$workspaces_dir/${script_name}.sh"
    
    if [[ -f "$script_path" && -x "$script_path" ]]; then
      "$script_path"
    else
      notify-send "Workspace not found" "Could not find: $script_path"
    fi
  else
    back_to show_main_menu
  fi
}

show_main_menu() {
  local options="󰀻  Apps\n󰧑  Learn\n󱓞  Trigger\n  Style\n  Setup\n󰉉  Install\n󰭌  Remove\n  Update\n󱆷  Workspaces\n  About\n  System"
  go_to_menu "$(menu "Go" "$options")"
}

go_to_menu() {
  case "${1,,}" in
  *apps*) walker -p "Launch…" ;;
  *learn*) show_learn_menu ;;
  *trigger*) show_trigger_menu ;;
  *style*) show_style_menu ;;
  *setup*) show_setup_menu ;;
  *install*) show_install_menu ;;
  *remove*) show_remove_menu ;;
  *update*) show_update_menu ;;
  *workspaces*) show_workspaces_menu ;;
  *about*) show_about ;;
  *system*) show_system_menu ;;
  esac
}
