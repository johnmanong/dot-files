# setup
SOURCE_ROOT='dot-files'  # this has to be set to path relative to $HOME
INIT_ROOT_DIR=$HOME/$SOURCE_ROOT

if [ ! -d $INIT_ROOT ]; then
	echo 'source_root must must be set to an available directory!'
	return 1
fi

PATH_GIT_COMPLETION=$INIT_ROOT_DIR/libs/local/.git-completion.bash
PATH_GIT_PROMPT=$INIT_ROOT_DIR/libs/local/.git-prompt.sh


__COLOR_CLI_DEFAULT="\[\e[0m\]"
__COLOR_CLI_DIR="\[\e[32;1m\]"
__COLOR_CLI_GIT="\[\e[36;1m\]"
__COLOR_CLI_USER="\[\e[31;1m\]"
__COLOR_CLI_PROMPT="\[\e[35;1m\]"

PS1_DIR="$__COLOR_CLI_DIR\w "
PS1_USER="$__COLOR_CLI_DEFAULT($__COLOR_CLI_USER\u$__COLOR_CLI_DEFAULT) "
PS1_GIT_BRANCH="\$(__git_ps1 '$__COLOR_CLI_DEFAULT[$__COLOR_CLI_GIT%s$__COLOR_CLI_DEFAULT]')"
PS1_PROMPT="$__COLOR_CLI_PROMPT\n\$ $__COLOR_CLI_DEFAULT"

PS1_VALUE=$PS1_DIR$PS1_USER$PS1_GIT_BRANCH$PS1_PROMPT


alias ls='ls -G'
CLICOLOR=1
export EDITOR=/usr/bin/vim

if [ -f $PATH_GIT_PROMPT ]; then
  source $PATH_GIT_PROMPT
  export PS1=$PS1_VALUE
fi

# GIT STUFF

if [ -f $PATH_GIT_COMPLETION ]; then
  source $PATH_GIT_COMPLETION
fi

# OSX stuff
alias show-hidden-finder='defaults write com.apple.finder AppleShowAllFiles YES'
alias hide-hidden-finder='defaults write com.apple.finder AppleShowAllFiles NO'


# PY STUFF
export WORKON_HOME=~/Envs
source `which virtualenvwrapper_lazy.sh`
export LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN=1

#RVM STUFF
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# PROJECT SPECIFIC
# Oscar pypi mirror
BUILDER_URL="http://builder:8000/simple/"
export PIP_FIND_LINKS="$BUILDER_URL"
export PIP_INDEX_URL="https://pypi.python.org/simple/"
export PIP_EXTRA_INDEX_URL="$BUILDER_URL"

export DATA_REPO='/Users/ong/code/data'

# ALIAS

## general
alias ..='cd ..'
alias la='ls -la'
alias speed_up_ios='sudo sysctl -w kern.timer.coalescing_enabled=0'
alias speed_up_ios_undo='sudo sysctl -w kern.timer.coalescing_enabled=1'
alias whereami='ifconfig | ack -o '192.168.128.169' | xargs echo "your ip address is:${1}"'
alias jsc='node'

# phabricator
alias d=''
alias ad='arc diff'
alias al='arc lint'
alias ado='arc diff --only'
alias adu='arc diff --update ${1}'

## virtual env wrapper
alias wo='workon'
alias da='deactivate'

## git
alias ga='git add'
alias gb='git branch'
alias gca='git commit --amend --no-edit'
alias gci='git commit'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd='git diff'
alias gs='git status'

# py
alias start-moto='moto_server -H 127.0.0.1 -p 3000 s3bucket_path'
alias start-docstor='./build_tools/trashcan/opython.py internal-site/internal_site/embedded/run.py --embedded --profile=docstor'
alias start-rosco='./build_tools/trashcan/opython.py internal-site/internal_site/embedded/run.py'
alias start-rosco-ext='./build_tools/trashcan/opython.py internal-site/internal_site/embedded/run.py --host=192.168.128.169'
alias start-web='/Users/ong/Envs/data/bin/python /Users/ong/code/data/web/manage.py runserver 8000'
alias trash-web='PYTHONPATH=oscar/trashcan /Users/ong/code/data/web/manage.py runserver 8000'
alias start-sweb='export LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN=1; python /Users/ong/code/data/web/oscar/trashcan/oscar/manage.py runserver 8000'

# pants
alias pants-build='./pants manhattan/manhattan:manhattan'
alias pants-build-dev='./pants manhattan/manhattan:manhattan_dev'
alias pants-run='./dist/manhattan.pex --environment=pants-local-development'
alias pants-run-dev='./dist/manhattan_dev.pex --environment=pants-local-development'
alias pants-embedded='./dist/manhattan_dev.pex --environment=pants-embedded-development --profile=quick'
alias pants-embedded-testing='./dist/manhattan_dev.pex --environment=pants-embedded-testing --profile=quick'
alias pbr='pants-build-dev && pants-run-dev'
alias pber='pants-build-dev && pants-embedded'
alias pbt='pants-build-dev && pants-embedded-testing --profile=oe --port=4444'

# arc
export PATH="$PATH:$INIT_ROOT_DIR/libs/arc/arcanist/bin" # Add arc (phab) to path
source $INIT_ROOT_DIR/libs/arc/arcanist/resources/shell/bash-completion

# elastic search
alias esearch='elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'

# symlink stuff
export PATH=$PATH:$HOME/bin

