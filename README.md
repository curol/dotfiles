# dotfiles

Minimalistic dotfiles.

## Dependencies

- [rsync](https://rsync.samba.org/)

- [burntsushi/ripgrep](https://github.com/BurntSushi/ripgrep)

- [junegunn/fzf](https://github.com/junegunn/fzf)

- [sharkdp/fd](https://github.com/sharkdp/fd)

- [sharkdp/bat](https://github.com/sharkdp/bat)

- [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

- [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

- [zsh-user/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

- [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf)

- [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)


## Getting started

> 1.) Using your package manager, install packages fzf, ripgrep, fd-find, bat, fzf, and rsync.

> *apt*

```sh
sudo apt-get install fzf ripgrep fd-find bat rsync
ln -s $(which fdfind) /usr/bin/fd 
```

> *brew*

```sh
brew install fzf ripgrep fd-find bat rsync
```

> 2.) Run install script. For non-interactive sessions, use the option `-f, --force`.

```sh
git clone https://github.com/curol/dotfiles

cd dotfiles

./install.sh
```

## Config files

- `.zshenv` - Runs on every new command.

- `.zprofile` - Runs only once on an interactive login shell session.
Commands in `.zprofile` should be variables that take some time to complete and/or variables not updated frequently.

- `.zshrc` - Runs on every interactive shell session.
Commands in `.zshrc` should be:
    - command completion, correction, suggestion, highlighting

    - aliases

    - key bindings

    - commands history management

    - set any variables that are only used in the interactive shell $LS_COLORS.

- `.aliases` - Stores aliases for shell. Current aliases are oppionionated.

- `.exports` - Stores shared environment variables for zsh/bash. 

- `.p10k.zsh` - Config for powerlevel10k terminal prompt. 
