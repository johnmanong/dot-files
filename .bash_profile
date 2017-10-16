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


# GIT STUFF
if [ -f $PATH_GIT_PROMPT ]; then
  source $PATH_GIT_PROMPT
  export PS1=$PS1_VALUE
fi

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

# GO STUFF
export GOPATH=$DATA_REPO/go_third_party_local:$DATA_REPO/go
export PATH=$PATH:$DATA_REPO/go_third_party_local/bin

#RVM STUFF
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## history
### ref: http://www.thegeekstuff.com/2008/08/15-examples-to-master-linux-command-line-history
export HISTCONTROL=ignoredups

# PROJECT SPECIFIC
# Oscar pypi mirror
BUILDER_URL="http://builder:8000/simple/"
export PIP_FIND_LINKS="$BUILDER_URL"
# export PIP_INDEX_URL="https://pypi.python.org/simple/"
export PIP_INDEX_URL="https://devpi.hioscar.com/root/oscar/+simple/"
export PIP_EXTRA_INDEX_URL="$BUILDER_URL"

export DATA_REPO='/Users/ong/code/data'

# ALIAS

## general
alias ..='cd ..'
alias cdd='cd ~/code/data'
alias la='ls -la'
alias speed_up_ios='sudo sysctl -w kern.timer.coalescing_enabled=0'
alias speed_up_ios_undo='sudo sysctl -w kern.timer.coalescing_enabled=1'
alias whereami='ifconfig | ack -o '192.168.128.169' | xargs echo "your ip address is:${1}"'
alias jsc='node'
alias h='history'

## hosts
alias hostname='host ong | awk -F '"'"'has address '"'"' '"'"'{ system("host " $2) }'"'"''

## jira
function jira() {
    open "https://jira.hioscar.com/browse/${1}"
}
alias j=jira

# pycharm
alias pc='/Applications/PyCharm.app/Contents/MacOS/pycharm' 

## phabricator
function d() {
    open "https://phabricator.hioscar.com/D${1}"
}
alias d=d
alias ad='arc diff'
alias al='arc lint'
alias ab='arc branch'
alias ado='arc diff --only'
alias adu='arc diff --update ${1}'

## virtual env wrapper
alias wo='workon'
alias da='deactivate'

## git
alias ga='git add'
alias gb='git branch'
alias gbr='gb --sort=-committerdate | head -n10'
alias gca='git commit --amend --no-edit'
alias gci='git commit'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gd='git diff'
alias gs='git status'
alias gg='git grep -n'
alias gcm='git checkout master'
alias grm='git rebase master'
alias gpm='git pull origin master'
alias gph='git push origin HEAD'

## git x {atom, sublime}
alias gda='git diff master --stat --name-only | xargs atom'
alias gds='git diff master --stat --name-only | xargs subl'
alias gdp='git diff master --name-only | xargs -n 1 -I"{}" echo $DATA_REPO/{} | xargs -n 1  /Applications/PyCharm.app/Contents/MacOS/pycharm'

## atom
alias a='atom'

## py
alias start-moto='moto_server -H 127.0.0.1 -p 3000 s3bucket_path'
alias start-docstor='./build_tools/trashcan/opython.py internal-site/internal_site/embedded/run.py --embedded --profile=docstor'
alias start-rosco='./build_tools/trashcan/opython.py internal-site/internal_site/embedded/run.py'
alias start-rosco-ext='./build_tools/trashcan/opython.py internal-site/internal_site/embedded/run.py --host=192.168.128.169'
alias start-web='/Users/ong/Envs/data/bin/python /Users/ong/code/data/web/manage.py runserver 8000'
alias trash-web='PYTHONPATH=oscar/trashcan /Users/ong/code/data/web/manage.py runserver 8000'
alias start-sweb='export LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN=1; python /Users/ong/code/data/web/oscar/trashcan/oscar/manage.py runserver 8000'
alias rosco-staging-deploy='./aurora update start whynotzoidberg/rosco/devel/rosco_staging aurora_config/rosco/rosco_staging.aurora'
alias rosco-prod-deploy='./aurora update start whynotzoidberg/rosco/prod/rosco aurora_config/rosco/rosco.aurora'

## pants
alias p='./pants'
alias pt='CFLAGS=-I/usr/local/opt/icu4c/include LDFLAGS=-L/usr/local/opt/icu4c/lib ./pants test'
alias pb='./pants goal build-deps --build-deps-virtualenv=data'
alias ptg='./pants target-gen --'
alias pgt='./pants gen-thrift-py thrift/src::'
alias pgp='./pants gen-protobuf-py protobuf::'

### builds
alias pants-build='./pants binary python/manhattan:manhattan'
alias pants-build-dev='./pants binary python/manhattan:manhattan_dev'

### run
alias pants-run='./dist/manhattan.pex --environment=pants-local-development'
alias pants-run-dev='./dist/manhattan_dev.pex --environment=pants-local-development'
alias pants-embedded='./dist/manhattan_dev.pex --environment=pants-embedded-development --profile=quick'
alias pants-embedded-testing='./dist/manhattan_dev.pex --environment=pants-embedded-testing --profile=quick'

### build and run
alias pbr='pants-build-dev && pants-run-dev'
alias pber='pants-build-dev && pants-embedded'

# integration testing
alias pri='./dist/manhattan_dev.pex --environment=pants-embedded-testing --profile=oe --port=4444'
alias pbri='pants-build-dev && pri'

# oscar github
alias git-personal='git config user.name johnmanong && git config user.email johnmanong@gmail.com && echo "name:" && git config user.name && echo "email:" && git config user.email'
alias git-oscar='git config user.name ong && git config user.email ong@hioscar.com && echo "name:" && git config user.name && echo "email:" && git config user.email'

# brew
export PATH="/usr/local/sbin:$PATH"

# node/iojs
# https://gist.github.com/phelma/ce4eeeedb8fb9a9e8e63
alias usenode='brew unlink iojs && brew link node && echo Using Node.js'
alias useio='brew unlink node && brew link --force iojs && echo Using io.js'

# more config

## pants
source $DATA_REPO/engshare/bin/pants_bash_autocomplete

## nvm
source ~/.nvm/nvm.sh

## arc
export PATH="$PATH:$INIT_ROOT_DIR/libs/arc/arcanist/bin" # Add arc (phab) to path
source $INIT_ROOT_DIR/libs/arc/arcanist/resources/shell/bash-completion

## elastic search
alias esearch='elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'

# symlink stuff
export PATH=$PATH:$HOME/bin

# remote hosts
resolve () {
        host $1 | awk '{ print $4  }' | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn} -v 'in' | xargs -I {} dig +short -x {}
}

# Django specific, please rm when done
durl () {
    git grep -n -e "redirect(['\"]$1['\"]" --or -e "reverse(['\"]$1['\"]" --or -e "url.* ['\"]$1['\"]"
}

# bash helper
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

# misfit file shuffle (TEMP)
alias msftp='sftp -P40050 -i ~/.ssh/oscar_misfit_sftp oscar@store-sftp.misfit.com'
alias osftp='sftp misfit@securedrop.hioscar.com'
alias cdmf='cd ~/stuff/misfit && wo data'
alias mfo='python upload_orders.py orders'
alias mfs='python upload_orders.py shipping'

# webpack stuff
alias wpm='cd ~/code/data && ./scripts/webpack_dev.js manhattan'

