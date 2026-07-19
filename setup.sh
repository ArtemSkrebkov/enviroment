#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Fix ownership of directories Docker may have created as root
fix_ownership() {
    local dir="$1"
    if [[ -d "$dir" && ! -O "$dir" ]]; then
        echo "  Fixing ownership of $dir (created by Docker as root)..."
        sudo chown -R "$USER:$USER" "$dir"
    fi
}

fix_ownership "$HOME/.tmux"
fix_ownership "$HOME/.tmux/plugins"
fix_ownership "$HOME/.local/share/nvim"
# fix_ownership "$HOME/.oh-my-zsh"

# Safely create a symlink, replacing a regular file or empty dir if present.
# Skips if the target is already the correct symlink.
safe_symlink() {
    local src="$1"
    local dst="$2"

    if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
        echo "  $dst already linked, skipping."
        return
    fi

    # Remove plain file or empty dir blocking the symlink
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        if [[ -d "$dst" ]]; then
            rmdir "$dst" 2>/dev/null || { echo "  WARNING: $dst is a non-empty dir, skipping symlink."; return; }
        else
            rm -f "$dst"
        fi
    fi

    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    echo "  $dst -> $src"
}

# --- symlink configs ---
echo "Linking dotfiles from $REPO_DIR..."
safe_symlink "$REPO_DIR/tmux/tmux.conf"         "$HOME/.tmux.conf"
safe_symlink "$REPO_DIR/nvim"                    "$HOME/.config/nvim"
safe_symlink "$REPO_DIR/starship/starship.toml"  "$HOME/.config/starship.toml"

# --- starship ---
STARSHIP_BIN="$HOME/.local/bin/starship"
if [[ ! -x "$STARSHIP_BIN" ]]; then
    echo "Installing starship..."
    mkdir -p "$HOME/.local/bin"
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$HOME/.local/bin" --yes
else
    echo "Starship already installed, skipping."
fi

# Patch ~/.bashrc to init starship (idempotent)
BASHRC="$HOME/.bashrc"
STARSHIP_INIT='eval "$(starship init bash)"'
if ! grep -qF 'starship init bash' "$BASHRC" 2>/dev/null; then
    echo "" >> "$BASHRC"
    echo "# starship prompt" >> "$BASHRC"
    echo "$STARSHIP_INIT" >> "$BASHRC"
    echo "  Patched $BASHRC with starship init."
else
    echo "  $BASHRC already has starship init, skipping."
fi

# --- GitHub Copilot CLI ---
COPILOT_BIN="$HOME/.local/bin/copilot"
if [[ ! -x "$COPILOT_BIN" ]]; then
    echo "Installing GitHub Copilot CLI..."
    curl -fsSL https://gh.io/copilot-install | bash
else
    echo "GitHub Copilot CLI already installed, skipping."
fi

# --- TPM (tmux plugin manager) ---
mkdir -p "$HOME/.tmux/plugins"
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM already installed, skipping."
fi

echo ""
echo "Done! Next steps:"
echo "  - Reload your shell: source ~/.bashrc"
echo "  - Log in to Copilot CLI: copilot /login"
echo "  - Start tmux and press Ctrl+Space I to install tmux plugins"
echo "  - Open nvim — plugins install automatically on first launch"
