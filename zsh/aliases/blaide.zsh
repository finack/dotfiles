bark() {
  local base_dir=~/src/blaide/ark

  if [ -z "$1" ]; then
    cd "$base_dir" || echo "Failed to change directory to $base_dir"
  else
    local sub_dir=$(find "$base_dir" -type d -name "$1" -print -quit)
    if [ -n "$sub_dir" ]; then
      cd "$sub_dir" || echo "Failed to change directory to $sub_dir"
    else
      echo "No matching directory found for $1"
    fi
  fi
}

alias fly_worker_logs='fly logs -i $(fly status --json | jq -r ".Machines[] | select(.config.metadata.fly_process_group == \"worker\") | .id" | head -n 1)'
