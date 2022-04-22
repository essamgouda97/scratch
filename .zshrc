export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="aussiegeek"

#plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='mvim'
fi

# asottile settings
command_not_found_handler() {
    if [ -x "venv/bin/$1" ]; then
        echo 'you forgot to activate ./venv -- I gotchu' 1>&2
        exe="venv/bin/$1"
        shift
        "$exe" "$@"
        return $?
    else
        echo "$0: $1: command not found" 1>&2
        return 127
    fi
}
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
[ -x /usr/bin/dircolors ] && eval "$(dircolors -b)"
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases
[ -d "$HOME/bin" ] && export PATH="${HOME}/bin:${PATH}"
PROMPT_COMMAND='if [ -d .git -a ! -x .git/hooks/pre-commit -a -e .pre-commit-config.yaml ] && command -v pre-commit >& /dev/null; then pre-commit install --hook-type pre-commit; fi; '"$PROMPT_COMMAND"
eval "$(aactivator init)"

export PYTHONSTARTUP=~/.pythonrc.py
export EDITOR=babi VISUAL=babi

export DEBEMAIL="egouda@ualberta.ca" DEBFULLNAME="Essam Gouda"

export PIP_DISABLE_PIP_VERSION_CHECK=1
export VIRTUALENV_NO_PERIODIC_UPDATE=1


