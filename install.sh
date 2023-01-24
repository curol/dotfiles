#!/usr/bin/env bash
#
# Install script for dotfiles. 
# Dotfiles: .exports, .aliases, .p10k.zsh, .zprofile, .zshenv, .zshrc
# This script should be run via curl or locally.
# Non-interactive installs should use option `-f, --force`.
#
# REQUIREMENTS
# - Dependencies: git, zsh, rsync, ripgrep, fd-find, fzf, bat
# - i.g., `brew install git rsync zsh fzf ripgrep fd-find bat`
# - i.g., `sudo apt-get install git rsync zsh fzf ripgrep fd-find bat`
#
# EXAMPLES
# I.g., curl usage:
# curl \
# --fail \
# --show-error \
# --silent \
# --location \
# https://raw.githubusercontent.com/curol/dotfiles/main/install.sh
#
# I.g., install dotfiles via curl:
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/curol/dotfiles/main/install.sh)"
#
# I.g., non-interactive install (use option `-f` ) via curl:
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/curol/dotfiles/main/install.sh)" "" -f
#
# I.g., install with args via curl:
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/curol/dotfiles/main/install.sh)" "" sync
#
# I.g., non-interactive install with args via curl:
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/curol/dotfiles/main/install.sh)" "" sync -f
#
# I.g., install with environment variables via curl:
# HOME=/path/to/home DOTFILES_DIR=/path/to/dotfiles bash -c "$(curl -fsSL https://raw.githubusercontent.com/curol/dotfiles/main/install.sh)"
#
# I.g., install via locally:
# chmod +x path/to/dotfiles/install.sh
# path/to/dotfiles/install.sh
#
# Or:
# bash /path/to/dotfiles/install.sh
#
# I.g., purge all installed files:
# ./install.sh clean
#
# I.g., write and ignore times from dotfiles to $HOME:
# ./install.sh overwrite
#
##############################################################################################

set -e

# Make sure important variables exist if not already defined
#
# $USER is defined by login(1) which is not always executed (e.g. containers)
# POSIX: https://pubs.opengroup.org/onlinepubs/009695299/utilities/id.html
USER=${USER:-$(id -u -n)}
# $HOME is defined at the time of login, but it could be unset. If it is unset,
# a tilde by itself (~) will not be expanded to the current user's home directory.
# POSIX: https://pubs.opengroup.org/onlinepubs/009696899/basedefs/xbd_chap08.html#tag_08_03
HOME="${HOME:-$(getent passwd $USER 2>/dev/null | cut -d: -f6)}"
# macOS does not have getent, but this works even if $HOME is unset
HOME="${HOME:-$(eval echo ~$USER)}"
# Oh-my-zsh directory `[[ ! -z "$ZSH" ]] && _zsh_dir="$ZSH" || _zsh_dir="$HOME/.oh-my-zsh"`
ZSH="${ZSH:-$HOME/.oh-my-zsh}"
# Dotfiles directory
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
# XDG DIRS
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
XDG_FONTS_DIR="${XDG_FONTS_DIR:-$HOME/.local/share/fonts}"
# Colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
# Nerdfonts
NFONT_NAME="Droid Sans Mono for Powerline Nerd Font Complete.otf"
NFONT_PATH="${XDG_FONTS_DIR}/${NFONT_NAME}"
NFONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf"
# ZSH plugin paths
_autosuggestions_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
_syntax_highlight_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
_powerlevel10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Install ZSH dependencies
_install_deps_if_they_dont_exist(){
    # Declare local variable i as the counter
    declare -i i=1

    # Create XDG directories if they dont exit
    mkdir -p "$XDG_DATA_HOME"
    mkdir -p "$XDG_FONTS_DIR"
    mkdir -p "$XDG_CACHE_HOME"
    mkdir -p "$XDG_BIN_HOME"
    mkdir -p "$XDG_CONFIG_HOME"

    # Install oh-my-zsh
    if [ ! -d "$ZSH" ]; then
      echo -e "\n${GREEN}${i} Installing oh-my-zsh into $ZSH ${RESET}"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      i+=1
    fi 

    # Install zsh-autosuggestions
    if [ ! -d "$_autosuggestions_dir" ]; then
        echo -e "\n${GREEN}${i} Installing zsh-autosuggestions into $_autosuggestions_dir ${RESET}"
        git clone https://github.com/zsh-users/zsh-autosuggestions.git  $_autosuggestions_dir 
        i+=1
    fi 

    # Install zsh-syntax-highlighting
    if [ ! -d "$_syntax_highlight_dir" ]; then
        echo -e "\n${GREEN}${i} Installing zsh-syntax-highlighting into into $_autosuggestions_dir ${RESET}"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $_syntax_highlight_dir
        i+=1
    fi 

    # Install powerlevel10k
    if [ ! -d "$_powerlevel10k_dir" ]; then
        echo -e "\n${GREEN}${i} Installing powerlevel10k into into $_powerlevel10k_dir ${RESET}"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $_powerlevel10k_dir
        i+=1
    fi 

    # Install dotfiles
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo -e "\n${GREEN}${i} Installing dotfiles into into $DOTFILES_DIR ${RESET}"
        git clone https://github.com/curol/dotfiles.git $DOTFILES_DIR
        i+=1
    fi 

    # Install nerdfonts
    if [ ! -e "$NFONT_PATH" ]; then
        echo -e "\n${GREEN}${i} Installing ${NFONT_NAME} into ${NFONT_PATH} ${RESET}"
        curl --output-dir "${XDG_FONTS_DIR}" -fLo "${NFONT_NAME}" "${NFONT_URL}"
        i+=1
    fi
}

# Remove dependencies
_clean(){
    local _dotfiles="$HOME/.zshrc $HOME/.zshenv $HOME/.zprofile $HOME/.aliases $HOME/.exports $HOME/.p10k.zsh"

    echo "${RED}"
    echo "This will remove files:"
    echo "(1) nerdfonts: ${NFONT_PATH}"
    echo "(2) zsh-autosuggestions: $_autosuggestions_dir"
    echo "(3) zsh-synatax-highlighting: $_syntax_highlight_dir"
    echo "(4) powerlevel10k: $_powerlevel10k_dir"
    echo -e "(5) dotfiles: ${_dotfiles}"

    echo "${RESET}";
    read -p "Are you sure? (y/n)" -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$_autosuggestions_dir" "$_syntax_highlight_dir" "$_powerlevel10k_dir" "$NFONT_PATH" $_dotfiles
        echo "Successfully removed files."
    else
        echo "Didn't remove any files. Exiting."
    fi;
}

# Sync dotfiles from $DOTFILES_DIR to $HOME
_sync(){
    local _src="${DOTFILES_DIR}/"
    local _des="${HOME}/"

    echo -e "\n${GREEN}Syncing $_src to $_des.${RESET}"

    rsync --exclude ".git/" \
      --exclude ".DS_Store" \
      --exclude ".osx" \
      --exclude "bootstrap.sh" \
      --exclude "README.md" \
      --exclude "LICENSE.txt" \
      --exclude "install.sh" \
      --no-perms \
      -avh \
      "$_src" "$_des";
}

# Write dotfiles from $DOTFILES_DIR to $HOME and ignore times
_overwrite(){
    local _src="${DOTFILES_DIR}/"
    local _des="${HOME}/"

    echo -e "\n${GREEN}Writing ${_src} to ${_des}.${RESET}"

    rsync --exclude ".git/" \
      --exclude ".DS_Store" \
      --exclude ".osx" \
      --exclude "bootstrap.sh" \
      --exclude "README.md" \
      --exclude "LICENSE.txt" \
      --exclude "install.sh" \
      --no-perms \
      --ignore-times \
      -avh \
      "$_src" "$_des";
}

# Run
# TODO: install required packages?
_run(){
    if [ "$1" == "clean" ]; then
            _clean
    else
        _install_deps_if_they_dont_exist
        case "$1" in
                "sync") _sync ;;
                "overwrite") _overwrite ;;
                "") _sync ;;
        esac
    fi
}

# Main
_main(){
    if [[ "$2" == "--force" ]] || [[ "$2" == "-f" ]]; then
        _run "$1"
    elif [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
        _run "$2"
    else
        echo "${GREEN}"
        echo "Path to dotfiles: ${DOTFILES_DIR}"
        echo "Path to home: ${HOME}"
        echo "${RESET}"
        #
        read -p "${RED}This may overwrite existing files in your home directory. Are you sure? (y/n) ${RESET}" -n 1;
        echo "";
        if [[ $REPLY =~ ^[Yy]$ ]]; then
                _run "$1"
        fi;
    fi
}

_main "$@"

unset _main
unset _run
unset _overwrite
unset _sync
unset _clean
unset _install_deps_if_they_dont_exist
unset NFONT_NAME
unset NFONT_PATH
unset NFONT_URL
unset RED
unset GREEN
unset RESET
unset _autosuggestions_dir
unset _powerlevel10k_dir
unset _syntax_highlight_dir