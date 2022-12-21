#####################################################################
# .zshrc
#
# .zshrc runs on interactive and non-interactive shells.
#####################################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git docker rsync ripgrep fzf fd encode64 gh vi-mode zsh-syntax-highlighting zsh-autosuggestions)

export HISTFILE=~/.zsh_history # Path to history file
export HISTSIZE=1000000000 # Number of commands loaded into memory
export SAVEHIST=$HISTSIZE # Number of commands saved to history file
setopt HIST_IGNORE_ALL_DUPS # Don't write duplicates to history file

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh 

source ~/.aliases