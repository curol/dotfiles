# dotfiles

Minimalistic dotfiles.

```sh
.
├── .aliases
├── .config
│   ├── brew
│   │   └── packages.txt
│   ├── fzf
│   │   ├── completions.zsh
│   │   ├── fzf.zsh
│   │   └── keybindings.zsh
│   ├── iterm2
│   │   └── Default.json
│   └── nvim
│       ├── .gitignore
│       ├── .neoconf.json
│       ├── LICENSE
│       ├── README.md
│       ├── init.lua
│       ├── lua
│       │   ├── config
│       │   │   ├── autocmds.lua
│       │   │   ├── keymaps.lua
│       │   │   ├── lazy.lua
│       │   │   └── options.lua
│       │   └── plugins
│       │       └── example.lua
│       └── stylua.toml
├── .exports
├── .p10k.zsh
├── .zprofile
├── .zshenv
├── .zshrc
├── README.md
└── install.sh

8 directories, 24 files
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

- `.config` - Directory for user-specific configuration files.

## Requirements

- [rsync](https://rsync.samba.org/)

- [burntsushi/ripgrep](https://github.com/BurntSushi/ripgrep)

- [junegunn/fzf](https://github.com/junegunn/fzf)

- [sharkdp/fd](https://github.com/sharkdp/fd)

- [sharkdp/bat](https://github.com/sharkdp/bat)

- [zsh](https://github.com/zsh-users/zsh)

> If not installed, install requirements using your package manager: `sudo apt-get install rsync git rg fzf fd-find bat zsh`

## Stack

- [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

- [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

- [zsh-user/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

- [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf)

- [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)

- [LazyVim/starter](https://github.com/LazyVim/starter)


## Getting started

**1.) Using your package manager, install requirements**

*apt*

```sh
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y zsh fzf ripgrep fd-find bat rsync git

# If using apt, you need to link fdfind to fd
ln -s $(which fdfind) /usr/bin/fd 
```

*brew*

```sh
brew install fzf ripgrep fd-find bat rsync git zsh
```

**2.) Run install script. For non-interactive sessions, use the option `-f, --force`.**

```sh
git clone https://github.com/curol/dotfiles

# Install interactively
# Or, install non-interactively using option -f: `./dotfiles/install.sh -f`
./dotfiles/install.sh
```


