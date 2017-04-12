# Path to your oh-my-zsh installation.
  export ZSH=/home/james/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

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
plugins=(git)

# User configuration

  export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/lib/node/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias zshconfig="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias awesomerc="vim ~/.config/awesome/rc.lua"
alias reloadZshConfig="source ~/.zshrc"
alias clearMaven="rm -rf ~/.m2/repository/au/com/clearboxsystems"
alias pgadmin="/opt/PostgreSQL/9.4/scripts/launchpgadmin.sh"
function projectSearch() {
    for d in */; do
        cd $d
        echo "\n\n++++++ SEARCH RESULTS IN $d ++++++\n\n"
        ag $1
        cd ../
    done
}
function gall() {
    for d in */; do
        cd $d
        git "$@"
        cd ../
    done
}
function fixXml() {
   CWD=($pwd)
   PROJECTS_TO_FIX=( devices services alarms alarms-api audit audit-api missions authenticate )

   for d in "$PROJECTS_TO_FIX[@]"; do
        cd /home/james/Projects/fivebone/java/$d
        mvn xml:transform
    done
    cd /home/james/Projects/fivebone/java/fs-cmc-5b1
    mvn clean compile
    cd $CWD
}

function recompileWeb() {
    cd /home/james/Projects/fivebone/web/fs-cmc-5b1.js
    rm -rf node_modules bower_components
    npm install
    grunt compile
    cd -
}

alias copyLocals="~fivebone/web/fs-cmc-5b1.js && grunt copy:locals && cd -"

alias runHemble="~hemble/hemble/npm start"

alias logOff="sudo service lightdm restart"

hash -d proj=~/Projects/
hash -d hemble=~/Projects/hemble
hash -d fivebone=~/Projects/fivebone

#JSAWK for Milestone stuff

function splitChildNodesToFile() {
    for child in $(jsawk -n -i $1 "for(var name in this) out(name); return null"); do
        mkdir $child
        outputChildNodeToFile $1 $child
    done
}

function outputChildNodeToFile() {
    jsawk -n -i $1 "out(this[\"$2\"]); return null" >> $2/$2.json
}

function makeDirs() {
    for entry in $1; do
        mkdir $entry
    done
}

function jsonProcessDirs() {
    for dir in */; do
        cd $dir
        splitChildNodesToFile ${dir%/*}.json
        cd ../
    done
}

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

function countdown(){
    date1=$((`date +%s` + $1)); 
    while [ "$date1" -ne `date +%s` ]; do 
        echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
        sleep 0.1
    done
}

function stopwatch(){
    date1=`date +%s`; 
    while true; do 
        echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
        sleep 0.1
    done
}

### HEMBLE COMMANDS ###
alias hViewProd='heroku logs -t -n 1000 --source app --app=guarded-thicket-1014'
alias hViewStaging='heroku logs -t -n 1000 --source app --app=hemble-staging'

alias deployStaging='gulp build-staging && gulp deploy-staging'
alias deployProd='gulp build-prod && gulp deploy-prod'

alias restartStaging='heroku ps:restart --app=hemble-staging'
alias restartProd='heroku ps:restart --app=guarded-thicket-1014'

function clearDb() {
    cd /home/james/Projects/hemble/hemble-server/db/migrations
    if [ -z "$1" ]
    then
        ../bin/migrate down 55
        ../bin/migrate up
    else
        if [ "$1" == "production" ]
        then
            echo "Cannot perform operations on production environment"
            exit -1
        else
            ../bin/migrate --env=$1 down 55
            ../bin/migrate --env=$1 up
        fi
    fi
    cd -
}

### AWESOME COMMANDS ###
alias logout='sudo service lightdm restart'

alias winFox='wine .wine/drive_c/Program\ Files\ \(x86\)/Mozilla\ Firefox/firefox.exe'

