# enviroment

Personal dotfiles and dev environment bootstrap for NPU plugin development.

## What's inside

| Path | Purpose |
|------|---------|
| `setup.sh` | Bootstrap script — run once locally and inside Docker |
| `tmux/tmux.conf` | tmux config (Ctrl+Space prefix, Dracula theme, resurrect) |
| `nvim/` | Neovim config (Space leader, Telescope, gruvbox) |
| `starship/starship.toml` | Starship prompt config (gruvbox-rainbow preset) |
| `CMakeUserPresets.json` | CMake presets for Clang |

## Bootstrap

```bash
bash setup.sh
source ~/.bashrc   # activate starship in the current shell
copilot /login     # authenticate GitHub Copilot CLI
```

`setup.sh` is idempotent — safe to re-run. It:
- Symlinks `tmux.conf`, `nvim/`, and `starship.toml` from this repo into `$HOME`
- Installs starship to `~/.local/bin` (if not present)
- Patches `~/.bashrc` to initialize starship (once)
- Installs GitHub Copilot CLI to `~/.local/bin` (if not present)
- Installs TPM (tmux plugin manager)

## Starship prompt

The prompt uses the **gruvbox-rainbow** preset, which matches the neovim gruvbox color scheme.
Requires **Nerd Fonts** — JetBrains Mono Nerd Font is recommended.

The config lives at `starship/starship.toml` (symlinked to `~/.config/starship.toml`).

### Switching presets

```bash
# Preview a preset
starship preset <name>

# Apply a different preset (overwrites starship.toml — commit the result)
starship preset <name> -o ~/sources/npu-project/enviroment/starship/starship.toml
```

Available presets: `gruvbox-rainbow`, `tokyo-night`, `pastel-powerline`, `nerd-font-symbols`, `plain-text-symbols`, and more at https://starship.rs/presets/
