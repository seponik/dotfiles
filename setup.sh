#!/bin/bash

# ─────────────────────────────────────────────
# Config
# ─────────────────────────────────────────────

REPO_URL="https://github.com/seponik/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

# ─────────────────────────────────────────────
# Colors
# ─────────────────────────────────────────────

SUCCESS="\033[1;32m"
INFO="\033[1;36m"
WARN="\033[1;33m"
ERROR="\033[1;31m"
LOGO="\033[1;37m"
RESET="\033[0m"

# ─────────────────────────────────────────────
# Utility Functions
# ─────────────────────────────────────────────

info()    { echo -e "${INFO}[+] $1${RESET}"; }
warn()    { echo -e "${WARN}[~] $1${RESET}"; }
success() { echo -e "${SUCCESS}[✓] $1${RESET}"; }
error()   { echo -e "${ERROR}[✗] $1${RESET}"; exit 1; }

logo() {
  echo -e "${LOGO}╭───────────────────╮"
  echo "│┏━┓┏━╸┏━┓┏━┓┏┓╻╻╻┏ │"
  echo "│┗━┓┣╸ ┣━┛┃ ┃┃┗┫┃┣┻┓│"
  echo "│┗━┛┗━╸╹  ┗━┛╹ ╹╹╹ ╹│"
  echo -e "╰───────────────────╯${RESET}"
}

clone_if_missing() {
  local repo="$1"
  local dest="$2"

  if [ ! -d "$dest" ]; then
    git clone --quiet --depth=1 "$repo" "$dest" > /dev/null 2>&1 || error "Failed to download ZSH plugins."
  fi
}

# ─────────────────────────────────────────────
# Core Functions
# ─────────────────────────────────────────────

update_repo() {
  warn "Updating existing dotfiles..."
  git -C "$DOTFILES_DIR" pull --quiet > /dev/null 2>&1 || error "Failed to update dotfiles."
}

clone_repo() {
  info "Downloading dotfiles..."
  git clone --quiet --depth=1 "$REPO_URL" "$DOTFILES_DIR" > /dev/null 2>&1 || error "Failed to download dotfiles."
}

link_files() {
  # ──────── VIM ────────
  ln -sf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
  ln -sf "$DOTFILES_DIR/vim/.vim" "$HOME/.vim"

  # ──────── ZSH ────────
  ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

  mkdir -p "$DOTFILES_DIR/zsh/plugins"

  clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions.git" "$DOTFILES_DIR/zsh/plugins/zsh-autosuggestions" 

  clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$DOTFILES_DIR/zsh/plugins/zsh-syntax-highlighting"

  # ──────── VSCODE ────────
  # TODO
}

main() {
  logo

  echo -e "${INFO}[•] Starting dotfiles setup...${RESET}"

  if [ -d "$DOTFILES_DIR" ]; then
    update_repo
  else
    clone_repo
  fi

  link_files

  success "Dotfiles setup complete."
}

# ─────────────────────────────────────────────
# Run
# ─────────────────────────────────────────────

main