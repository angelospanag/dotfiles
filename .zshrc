alias up="brew update && brew upgrade --greedy && brew autoremove && brew cleanup --prune=all && mise upgrade"
alias python="python3"
alias myip="curl ifconfig.me"

# Enable signing commits from console
export GPG_TTY=$(tty)

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi="nvim"

alias uuid4="python3 -c \"import uuid; print(uuid.uuid4())\""
alias uuid7="python3 -c \"import uuid; print(uuid.uuid7())\""

# Git
alias git-clean='git fetch --prune && git branch -vv | grep ": gone]" | awk "{print \$1}" | xargs -r git branch -d'

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
