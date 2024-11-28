# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:~/.spoof-dpi/bin"
export PATH="$PATH:~/.dotnet/tools"

# Add matlab cli
export PATH="$PATH:/Applications/MATLAB_R2023b.app/bin"

# Add c++ compilation flags
export CXXFLAGS="-std=c++17"

# dotnet 6
#export PATH="/opt/homebrew/Cellar/dotnet@6/6.0.125/bin:$PATH"
#export DOTNET_ROOT="/opt/homebrew/Cellar/dotnet@6/6.0.125"

# Java 8
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home"
# Java 17
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
# Java 21
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home"
export PATH="$PATH:$JAVA_HOME"

export ARINA="/Users/m/work/arina-2.0/src"

export RARI="/Users/m/dev/c/rari-renderer"

export EDITOR="nvim"

# export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="unix://${HOME}/.colima/docker.sock"
# Use colima for docker
# export DOCKER_HOST="unix://${HOME}/.colima/docker.sock"
export DOCKER_HOST="unix://${HOME}/.colima/arm/docker.sock"
# Use podman for docker
#export DOCKER_HOST='unix:///var/folders/l8/3470pshj78q2mv7_zbv_r58h0000gn/T/podman/podman-machine-default-api.sock'

ZSH_THEME="robbyrussell" # set by `omz`

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' frequency 14

#FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

plugins=(git gitfast web-search zsh-syntax-highlighting mvn)

source $ZSH/oh-my-zsh.sh

jrun() {
	javac "$1.java" && java $1
}

srun() {
	scalac "$1.scala" && scala "Main"
}

rundocker() {
	open /Applications/Docker.app
}

killdocker() {
	sudo pkill docker
}

merge() {
	FILE_A="$1"
	FILE_B="$2"
	MERGED="${3:-merged.pdf}"

	scp "$FILE_A" "$FILE_B" root@arch:/tmp
	ssh root@arch "pdftk /tmp/$FILE_A /tmp/$FILE_B cat output /tmp/$MERGED"
	scp root@arch:/tmp/"$MERGED" .
}

add_git_aliases() {
	# alias gco="git checkout"
	# alias gcm="git commit -m"
	# alias gp="git push"
	# alias gl="git pull"
	# alias gss="git status --short"
	# alias gca="git commit --amend"
	# alias gcan="git commit --amend --no-edit"
	# alias gaa="git add --all"
	# alias ga="git add"
	# alias gbd="git branch --delete"
	# alias gbD="git branch --delete --force"
	# alias glog="git log --oneline --decorate --graph"
	# alias gloga="git log --oneline --decorate --graph --all"
	# alias grv="git remote --verbose"
	# alias gstl="git stash list"
	# alias gstp="git stash push"
	# alias gstp="git stash pop"
	# alias gd="gd"
	# alias gcb="git checkout -b"
}

alias vi="nvim"
alias db="dotnet build"
alias dc="dotnet clean"
alias java="/usr/bin/java"
add_git_aliases
alias cd=z

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(fzf --zsh)"
eval "$(pip completion --zsh)"
eval "$(colima completion zsh)"
eval "$(zoxide init zsh)"
eval "$(kubectl completion zsh)"

# export STM32CubeMX_PATH=/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources
# export STM32_PRG_PATH=/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/MacOs/bin

is_in_git_repo() {
	git rev-parse HEAD >/dev/null 2>&1
}

fzf_git_branch() {
	is_in_git_repo && git branch -a --color=always | grep -v '/HEAD\s' |
		fzf --height 40% --ansi --multi --tac | sed 's/^..//' | awk '{print $1}' |
		sed 's#^remotes/[^/]*/##'
}

gcof() {
        git checkout $(fzf_git_branch)
}

gcoff() {
        git checkout -f $(fzf_git_branch)
}

alias gcl="gitlab-ci-local"

[ -f "/Users/m/.ghcup/env" ] && . "/Users/m/.ghcup/env" # ghcup-env

HISTSIZE=1000000    # Number of commands to keep in memory
SAVEHIST=1000000    # Number of commands to save in the history file
HISTFILE=${HOME}/.zsh_history  # Path for the history file

setopt INC_APPEND_HISTORY  # Write to history file immediately
setopt SHARE_HISTORY       # Share history across all sessions
setopt HIST_IGNORE_DUPS    # Ignore duplicate commands

