# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# History
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
shopt -s checkwinsize

# Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias up="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && mise upgrade && mise prune -y"
alias myip='curl -s ifconfig.me; echo'

# Go binaries (gopls and friends land here)
export PATH="$HOME/go/bin:$PATH"

# Enable signing commits from console
export GPG_TTY=$(tty)

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

# Extract audio from a video URL
ytmp3() {
  yt-dlp -x --audio-format mp3 --audio-quality 0 "$1"
}

# Nuke package manager caches
nuke-caches() {
  read -r -n 1 -p "Nuke uv, pnpm, bun, and go caches? [y/N] " REPLY
  echo
  [[ $REPLY == [yY] ]] || return 1
  command -v uv   >/dev/null && uv cache clean
  command -v pnpm >/dev/null && rm -rf "$(pnpm store path)" && pnpm cache delete 2>/dev/null
  command -v bun  >/dev/null && rm -rf "$HOME/.bun/install/cache"
  command -v go   >/dev/null && go clean -cache -modcache -testcache -fuzzcache
  echo "Caches cleared."
}

# Telemetry off
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export NEXT_TELEMETRY_DISABLED=1
export TELEMETRY_DISABLED=1
export GH_TELEMETRY=false

# Mise
eval "$(mise activate bash)"

# Starship
eval "$(starship init bash)"
