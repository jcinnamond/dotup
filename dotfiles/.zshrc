# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="john"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vagrant)

source $ZSH/oh-my-zsh.sh


# Adds a directory to the PATH, unless it already exists.
#
# Pass in the name of the directory to add as the first argument. Pass 
# in "s" as the second argument to add the directory to the start of the 
# PATH.
function addpath {
  if [ -n "$1" ]
  then
    pattern=`echo $1 | sed -e 's/\./\\\./'`
    echo $PATH | grep -q "$pattern"
    if [ $? -ne 0 ]
    then
	    if [ X$2 = Xs ]
      then
        PATH=$1:$PATH
	    else
        PATH=$PATH:$1
	    fi
    fi
  fi
}

addpath $HOME/bin
addpath ./bin s

export EDITOR=vim

export SSH_AGENT_PATH=$HOME/.ssh/ssh_auth_sock
