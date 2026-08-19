autoload -Uz compinit && compinit

# Force emacs keybindings so Ctrl+R (history search) works
bindkey -e

alias up="brew update && brew upgrade -y --greedy && brew autoremove && brew cleanup --prune=all && mise upgrade && mise prune -y"
alias myip='curl -s ifconfig.me; echo'

# Go binaries (gopls and friends land here)
export PATH="$HOME/go/bin:$PATH"

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

# Nuke package manager caches
nuke-caches() {
  read -q "REPLY?Nuke uv, pnpm, bun, and go caches? [y/N] " || return 1
  echo
  command -v uv   >/dev/null && uv cache clean
  command -v pnpm >/dev/null && rm -rf "$(pnpm store path)" && pnpm cache delete 2>/dev/null
  command -v bun  >/dev/null && rm -rf "$HOME/.bun/install/cache"
  command -v go   >/dev/null && go clean -cache -modcache -testcache -fuzzcache
  echo "Caches cleared."
}

# Telemetry off
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HOMEBREW_NO_ANALYTICS=1
export NEXT_TELEMETRY_DISABLED=1
export TELEMETRY_DISABLED=1
export GH_TELEMETRY=false

# Mise
eval "$(mise activate zsh)"

# Starship
eval "$(starship init zsh)"
