#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$HOME"

echo "Collecting dotfiles from $HOME_DIR to $DOTFILES_DIR"

# ~/ -> rc/
cp "$HOME_DIR/.bashrc"       "$DOTFILES_DIR/rc/.bashrc"
cp "$HOME_DIR/.bash_aliases" "$DOTFILES_DIR/rc/.bash_aliases"
cp "$HOME_DIR/.zshrc"        "$DOTFILES_DIR/rc/.zshrc"
cp "$HOME_DIR/.zsh_aliases"  "$DOTFILES_DIR/rc/.zsh_aliases"
cp "$HOME_DIR/.vimrc"        "$DOTFILES_DIR/rc/.vimrc"
cp "$HOME_DIR/.xbindkeysrc"  "$DOTFILES_DIR/rc/.xbindkeysrc"

# ~/ -> config/ individual files
cp "$HOME_DIR/.tmux.conf"   "$DOTFILES_DIR/config/.tmux.conf"
cp "$HOME_DIR/.gitmux.conf" "$DOTFILES_DIR/config/.gitmux.conf"

# ~/.config/ -> config/ individual files
cp "$HOME_DIR/.config/picom.conf"   "$DOTFILES_DIR/config/picom.conf"
cp "$HOME_DIR/.config/compton.conf" "$DOTFILES_DIR/config/compton.conf"
cp "$HOME_DIR/.config/terminalrc"   "$DOTFILES_DIR/config/terminalrc"

# ~/.config/ directories -> config/
for dir in nvim i3 i3status polybar espanso neofetch; do
    mkdir -p "$DOTFILES_DIR/config/$dir"
    cp -r "$HOME_DIR/.config/$dir/." "$DOTFILES_DIR/config/$dir/"
done

# ~/scripts/ -> scripts/
mkdir -p "$DOTFILES_DIR/scripts"
cp -r "$HOME_DIR/scripts/." "$DOTFILES_DIR/scripts/"

echo "Done."
