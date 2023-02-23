# dotfiles

Minimalistic dotfiles.

## 1. Stack

- [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

- [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

- [zsh-user/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

- [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf)

- [romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)

- [LazyVim/starter](https://github.com/LazyVim/starter)

## 2. Getting started

Install dependcies, clone repo, and install dotfiles. For an uninteractive terminal, use option `-f`, `./dotfiles/install.sh -f`

*Requirements*

*If requirements are not installed, install requirements using your package manager*

- [rsync](https://rsync.samba.org/)

- [burntsushi/ripgrep](https://github.com/BurntSushi/ripgrep)

- [junegunn/fzf](https://github.com/junegunn/fzf)

- [sharkdp/fd](https://github.com/sharkdp/fd)

- [sharkdp/bat](https://github.com/sharkdp/bat)

- [eth-p/bat-extras](https://github.com/eth-p/bat-extras)

- [zsh](https://github.com/zsh-users/zsh)

### 2.1. *Ubuntu/Debian*

For ubuntu/debian, use package manager `apt`

1.) Install packages

```bash
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install -y zsh fzf ripgrep fd-find bat rsync git curl wget
```

2.) Link fdfind to fd

```bash
ln -s $(which fdfind) /usr/bin/fd 
```

3.) Install bat extras 

```bash
    BAT_EXTRAS_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/bat-extras"

    git clone https://github.com/eth-p/bat-extras "$BAT_EXTRAS_PATH"

    "$BAT_EXTRAS_PATH/build.sh" --install
```

4.) Clone repo

```bash
git clone https://github.com/curol/dotfiles ~/dotfiles
```

5.) Install dotfiles

```bash
./dotfiles/install.sh
```

For an uninteractive terminal, use option `-f`

```bash
 ./dotfiles/install.sh -f
```

### 2.2. *Mac*

For mac, use package manager `brew`

1.) Install packages

```sh
brew install fzf ripgrep fd-find bat rsync git zsh curl wget eth-p/software/bat-extras
```

2.) Clone repo

```bash
git clone https://github.com/curol/dotfiles ~/dotfiles

```

3.) Install dotfiles

```bash
./dotfiles/install.sh
```

## 3. Dotfiles

```sh
.
├── .aliases
├── .exports
├── .p10k.zsh
├── .zprofile
├── .zshenv
├── .zshrc
└── .config
    ├── brew
    │   └── packages.txt
    ├── fzf
    │   ├── completions.zsh
    │   ├── fzf.zsh
    │   └── keybindings.zsh
    ├── iterm2
    │   ├── Default.json
    │   ├── default-and-natural-keybindings.itermkeymap
    │   └── default-keybindings.itermkeymap
    ├── nvim
    │   ├── .gitignore
    │   ├── .neoconf.json
    │   ├── LICENSE
    │   ├── init.lua
    │   ├── stylua.toml
    │   └── lua
    │       ├── config
    │       │   ├── autocmds.lua
    │       │   ├── keymaps.lua
    │       │   ├── lazy.lua
    │       │   └── options.lua
    │       └── plugins
    │           └── example.lua
    └── vscode
        └── js.code-profile

10 directories, 24 files
```

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