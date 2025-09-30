#╭───────────────────╮
#│┏━┓┏━╸┏━┓┏━┓┏┓╻╻╻┏ │
#│┗━┓┣╸ ┣━┛┃ ┃┃┗┫┃┣┻┓│
#│┗━┛┗━╸╹  ┗━┛╹ ╹╹╹ ╹│
#╰───────────────────╯

# ─────────────────────────────────────────────
# ZSH CONFIG
# ─────────────────────────────────────────────

autoload -U colors && colors

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history
setopt histignorealldups sharehistory appendhistory histverify

bindkey -e

autoload -Uz compinit
compinit

# ─────────────────────────────────────────────
# KEY BINDINGS
# ─────────────────────────────────────────────

bindkey '^[[1;5C' forward-word                    # Ctrl+Right
bindkey '^[[1;5D' backward-word                   # Ctrl+Left
bindkey '^H' backward-kill-word                   # Ctrl+Backspace
bindkey '^R' history-incremental-search-backward  # Ctrl+R

# ─────────────────────────────────────────────
# PLUGINS
# ─────────────────────────────────────────────

ZSH_PLUGIN_DIR="$HOME/.dotfiles/zsh/plugins"

[[ -f $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && 
  source $ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh

[[ -f $ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && 
  source $ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ─────────────────────────────────────────────
# ALIASES
# ─────────────────────────────────────────────

# ──────── LS ────────
alias la='ls -la'
alias ll='ls -lah'
alias ls='ls --color=auto'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# ──────── GIT ────────
alias gl='git log --oneline --graph --decorate'
alias ga='git add'
alias gs='git status -s'
alias gc='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gp='git push'
alias gpl='git pull'

# ──────── RM ────────
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ──────── GREP ────────
alias grep='grep --color'

# ─────────────────────────────────────────────
# COMPLETION SYSTEM
#─────────────────────────────────────────────

# Auto-description for completions
zstyle ':completion:*' auto-description 'specify: %d'

# Colors in completion
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Group completions by category
zstyle ':completion:*' group-name ''

# Menu selection for completions
zstyle ':completion:*' menu select=2

# Don't use old completion system
zstyle ':completion:*' use-compctl false

# Case-insensitive matching + smart case
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# ─────────────────────────────────────────────
# VERSION CONTROL INFO
# ─────────────────────────────────────────────

autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %F{8}·%f %F{5}%b%f'
zstyle ':vcs_info:git:*' actionformats ' %F{8}·%f %F{5}%b%f %F{1}(%a)%f'

precmd() {
  vcs_info
}

# ─────────────────────────────────────────────
# PROMPT CONFIG
# ─────────────────────────────────────────────

typeset -A prompt_colors
prompt_colors=(
  struct      '%F{8}'
  clock       '%F{7}'
  userhost    '%F{4}'
  path        '%F{6}'
  git_branch  '%F{5}'
  reset       '%f'
)

PROMPT='${prompt_colors[struct]}╭─[${prompt_colors[reset]}${prompt_colors[userhost]}%n${prompt_colors[reset]}${prompt_colors[struct]}@${prompt_colors[reset]}${prompt_colors[userhost]}%m${prompt_colors[reset]}${prompt_colors[struct]}]──[${prompt_colors[reset]}${prompt_colors[path]}%2~${prompt_colors[reset]}${prompt_colors[struct]}]${prompt_colors[reset]}${vcs_info_msg_0_}
${prompt_colors[struct]}╰─╼${prompt_colors[reset]} '

RPROMPT='${prompt_colors[struct]}%D{%Y.%m.%d}${prompt_colors[reset]} ${prompt_colors[clock]}%D{%H:%M}${prompt_colors[reset]} '

# ─────────────────────────────────────────────
# PATH CONFIG
# ─────────────────────────────────────────────

# ──────── PNPM ────────
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ──────── LOCAL BIN ────────
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# ─────────────────────────────────────────────
# ADDITIONAL SETTINGS
# ─────────────────────────────────────────────

setopt autocd

setopt correct

setopt extendedglob

# ─────────────────────────────────────────────
# STARTUP
# ─────────────────────────────────────────────

# fastfetch