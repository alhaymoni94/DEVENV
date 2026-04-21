#!/usr/bin/env bash
# install-fonts.sh — Install JetBrainsMono Nerd Font

set -euo pipefail

OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
  FONT_DIR="$HOME/Library/Fonts/JetBrainsMono"
else
  FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
fi

echo "Installing JetBrainsMono Nerd Font to $FONT_DIR ..."
mkdir -p "$FONT_DIR"

TMP="$(mktemp -d)"
curl -Lo "$TMP/JetBrainsMono.zip" \
  "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
unzip -o "$TMP/JetBrainsMono.zip" "*.ttf" -d "$FONT_DIR/"
rm -rf "$TMP"

if [[ "$OS" != "Darwin" ]]; then
  fc-cache -fv "$FONT_DIR"
fi

echo "Done. Restart WezTerm (or your terminal) to apply."
