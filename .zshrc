autoload -Uz compinit && compinit

# Force emacs keybindings so Ctrl+R (history search) works
bindkey -e

alias up="brew update && brew upgrade -y --greedy && brew autoremove && brew cleanup --prune=all && mise upgrade && mise prune -y"
alias myip='curl -s ifconfig.me; echo'

# Go binaries (gopls and friends land here)
export PATH="$HOME/go/bin:$PATH"

# Homebrew curl (keg-only, so not linked into PATH by default)
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# Enable signing commits from console
export GPG_TTY=$TTY

# Editor
export EDITOR=nvim
export VISUAL=nvim

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi='nvim'
alias vim='nvim'

alias uuid4="python3 -c \"import uuid; print(uuid.uuid4())\""
alias uuid7="python3 -c \"import uuid; print(uuid.uuid7())\""

# Git: delete local branches whose upstream is gone
git-gone() {
  git fetch --prune
  git for-each-ref --format '%(refname:short) %(upstream:track)' refs/heads |
    awk '$2 == "[gone]" { print $1 }' |
    xargs -r git branch -d
}

# macOS: list saved Wi-Fi networks
alias wifi-list="networksetup -listpreferredwirelessnetworks en0"

# Extract audio from a video URL
ytmp3() {
  yt-dlp -x --audio-format mp3 --audio-quality 0 "$1"
}

# Total size of the given paths in KB
_nuke_kb() {
  du -sk "$@" 2>/dev/null | awk '{ total += $1 } END { print total + 0 }'
}

# Print space freed: label, size before cleaning in KB, then the cleaned paths
_nuke_report() {
  local label=$1 before=$2 after
  shift 2
  after=$(_nuke_kb "$@")
  awk -v label="$label" -v kb="$((before - after))" 'BEGIN {
    if (kb >= 1048576) printf "%-6s %.1f GB\n", label, kb / 1048576
    else printf "%-6s %.1f MB\n", label, kb / 1024
  }'
}

# Nuke package manager caches
nuke-caches() {
  read -q "REPLY?Nuke uv, pnpm, bun, go, and cargo caches? [y/N] " || return 1
  echo
  local dir dir2 before
  if command -v uv >/dev/null; then
    dir=$(uv cache dir); before=$(_nuke_kb "$dir")
    uv cache clean >/dev/null
    _nuke_report uv "$before" "$dir"
  fi
  if command -v pnpm >/dev/null; then
    dir=$(pnpm store path); before=$(_nuke_kb "$dir")
    rm -rf "$dir" && pnpm cache delete >/dev/null 2>&1
    _nuke_report pnpm "$before" "$dir"
  fi
  if command -v bun >/dev/null; then
    dir="$HOME/.bun/install/cache"; before=$(_nuke_kb "$dir")
    rm -rf "$dir"
    _nuke_report bun "$before" "$dir"
  fi
  if command -v go >/dev/null; then
    dir=$(go env GOCACHE); dir2=$(go env GOMODCACHE); before=$(_nuke_kb "$dir" "$dir2")
    go clean -cache -modcache -testcache -fuzzcache
    _nuke_report go "$before" "$dir" "$dir2"
  fi
  if command -v cargo >/dev/null; then
    dir="${CARGO_HOME:-$HOME/.cargo}/registry"; dir2="${CARGO_HOME:-$HOME/.cargo}/git"; before=$(_nuke_kb "$dir" "$dir2")
    rm -rf "$dir" "$dir2"
    _nuke_report cargo "$before" "$dir" "$dir2"
  fi
  echo "Caches cleared."
}

# Telemetry off
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HOMEBREW_NO_ANALYTICS=1
export NEXT_TELEMETRY_DISABLED=1
export TELEMETRY_DISABLED=1
export GH_TELEMETRY=false

# Mise
export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate zsh)"

# Starship
eval "$(starship init zsh)"
