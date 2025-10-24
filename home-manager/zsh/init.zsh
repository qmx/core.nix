# Zsh options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt extendedglob

# GPG setup (Home Manager's gpg-agent service handles the agent)
export GPG_TTY=$(tty)

# Smart SSH_AUTH_SOCK setting - only override if unset or pointing to Apple launchd
if [[ -z "$SSH_AUTH_SOCK" ]] || [[ "$SSH_AUTH_SOCK" == *"apple.launchd"* ]]; then
       SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
       export SSH_AUTH_SOCK
fi
