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

fly_wrapper() {
    local environment="$1"
    local app="$2"
    
    # Check if the environment and app are provided
    if [[ -z "$environment" || -z "$app" ]]; then
        echo "Usage: fly_wrapper <environment> <app>"
        return 1
    fi

    # Build the appropriate argument for fly
    local arg="-a blaide-${environment}-${app}"
    
    # Call the original fly command with the constructed argument
    echo token: $FLY_API_TOKEN
    echo fly "${@:3}" $arg
    command fly "${@:3}" $arg
}

# Create aliases for convenience
fsj() { fly_wrapper "staging" "julia" "$@"; }
fsd() { fly_wrapper "staging" "dinah" "$@"; }
fpj() { fly_wrapper "production" "julia" "$@"; }
fpd() { fly_wrapper "production" "dinah" "$@"; }
