# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation
export ZSH=/Users/yingdai/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="ys"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump zsh-completions osx brew emacs sudo solarized-man)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias antlr4='java -jar /usr/local/lib/antlr-4.7-complete.jar'
alias ap2='antlr4 -Dlanguage=Python2'
alias grun='java org.antlr.v4.gui.TestRig'
export CLASSPATH=".:/usr/local/lib/antlr-4.7-complete.jar:$CLASSPATH"
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias lg='ssh cloud'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

alias blog='open https://yydai.github.io'

alias gp='git add .;git commit -m "Auto push";git push'
alias v='vim'
alias e='emacs -q'
alias zshrc='vim ~/.zshrc && source $_'
alias l='ls'

auto_push() {
    git add .
    local branch=$1
    shift
    local desc="$1"
    if [ -z "$1" ]; then
        desc="Auto commit"
    fi
    git commit -m "$desc" || true
    git pull --rebase
    git push
}

read_config() {
    local CONFIG="/Users/yingdai/.config/zsh-command/path.config"
    source $CONFIG

    local branch="master"

    temp=$1
    case $temp in
    -b) branch=$2
        shift 2
       ;;
    esac

    if [ -z "$1" ]; then
        auto_push $branch
    elif ! cat $CONFIG | grep "$1" > /dev/null; then
	echo "====Pushing in current directory===="
        auto_push -b $branch $1
    else
        local temp=${1}_path
	temp=${(P)temp}
	echo "====Pushing in $temp===="
        pushd $temp> /dev/null # we use pushd instead of cd
	auto_push $branch $2
	popd > /dev/null
    fi
}

# https://superuser.com/questions/935374/difference-between-and-in-shell-script
# https://unix.stackexchange.com/questions/68035/foo-and-zsh

alias p="read_config"

mc() {
    mkdir $1
    cd $1
}

alias xx='od -Ax -tcx1'
