#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$HOME"

echo "Deploying dotfiles from $DOTFILES_DIR to $HOME_DIR"

# rc/ -> ~/
cp "$DOTFILES_DIR/rc/.bashrc"       "$HOME_DIR/.bashrc"
cp "$DOTFILES_DIR/rc/.bash_aliases" "$HOME_DIR/.bash_aliases"
cp "$DOTFILES_DIR/rc/.zshrc"        "$HOME_DIR/.zshrc"
cp "$DOTFILES_DIR/rc/.zsh_aliases"  "$HOME_DIR/.zsh_aliases"
cp "$DOTFILES_DIR/rc/.vimrc"        "$HOME_DIR/.vimrc"
cp "$DOTFILES_DIR/rc/.xbindkeysrc"  "$HOME_DIR/.xbindkeysrc"

# config/ individual files -> ~/
cp "$DOTFILES_DIR/config/.tmux.conf"   "$HOME_DIR/.tmux.conf"
cp "$DOTFILES_DIR/config/.gitmux.conf" "$HOME_DIR/.gitmux.conf"

# config/ individual files -> ~/.config/
cp "$DOTFILES_DIR/config/picom.conf"   "$HOME_DIR/.config/picom.conf"
cp "$DOTFILES_DIR/config/compton.conf" "$HOME_DIR/.config/compton.conf"
cp "$DOTFILES_DIR/config/terminalrc"   "$HOME_DIR/.config/terminalrc"

# config/ directories -> ~/.config/
for dir in nvim i3 i3status polybar espanso neofetch; do
    mkdir -p "$HOME_DIR/.config/$dir"
    cp -r "$DOTFILES_DIR/config/$dir/." "$HOME_DIR/.config/$dir/"
done

# scripts/ -> ~/scripts/
mkdir -p "$HOME_DIR/scripts"
cp -r "$DOTFILES_DIR/scripts/." "$HOME_DIR/scripts/"

echo "Done."
