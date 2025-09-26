#!/bin/bash

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

REPO_URL="https://github.com/seponik/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

echo "╭───────────────────╮"
echo "│┏━┓┏━╸┏━┓┏━┓┏┓╻╻╻┏ │"
echo "│┗━┓┣╸ ┣━┛┃ ┃┃┗┫┃┣┻┓│"
echo "│┗━┛┗━╸╹  ┗━┛╹ ╹╹╹ ╹│"
echo "╰───────────────────╯"

echo -e "${CYAN}[•] Starting dotfiles setup...${RESET}"

if [ -d "$DOTFILES_DIR" ]; then
  echo -e "${YELLOW}[~] Updating existing dotfiles repo...${RESET}"
  git -C "$DOTFILES_DIR" pull
else
  echo -e "${GREEN}[+] Downloading dotfiles...${RESET}"
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

ln -sf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
ln -sfn "$DOTFILES_DIR/vim/.vim" "$HOME/.vim"