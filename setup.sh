sudo apt install clang-12 cmake git tmux neovim zsh curl
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# set zsh default-terminal for tmux and terminal
# create folders for work
cd ~
mkdir -p workspace/repos
mkdir -p workspace/tmp

# plugin manager for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# vim setup
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
