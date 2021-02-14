########################################################################
# SSH AGENT WSL WINDOWS
########################################################################
# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    touch $SSH_ENV
    chmod 600 "${SSH_ENV}"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    kill -0 $SSH_AGENT_PID 2>/dev/null || {
        start_agent
    }
else
    start_agent
fi


# Windows WSL -> CD to linux home
cd $HOME

########################################################################
# LINUX AND WINDOWS
########################################################################
# DOWNLOAD NEEDED PLUGINS
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ZSH_CUSTOM=~/zsh_custom
# Preferred editor for local and remote sessions
export EDITOR='nvim'
export VTE_VERSION="100"
export COMPLETION_WAITING_DOTS="true"

ZSH_THEME="awesomepanda"

LS_COLORS='ow=01;36;40'


plugins=(
        git
        sudo
        kubectl
        command-not-found
        docker
        zsh-syntax-highlighting
        zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh




########################################################################
# ALIAS
########################################################################

# GENERIC
alias tmux='TERM=xterm-256color tmux'
alias sshadd='ssh-add ~/.ssh/id_rsa'
alias gall='REPODIR="~/git"; OPWD=$(pwd); echo "Pulling all on $REPODIR"; for i in $(ls $REPODIR); do cd "$REPODIR/$i" ; echo "    Pulling $i";git pull > /dev/null 2>&1; done; cd $OPWD'
alias upall='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias vim='nvim'
alias dc='docker-compose'
alias adig='dig +noall +answer'
alias vimrc='vim ~/.config/nvim/init.vim'
alias zshrc='vim ~/.zshrc && source ~/.zshrc'
alias pipi='OLDPWD=$(pwd);cd $(git rev-parse --show-toplevel); if [ -d .venv ];then pip install autopep8 jedi neovim pylint; else; virtualenv .venv; pip install autopep8 jedi neovim pylint; fi; cd $OLDPWD'

# KUBERNETES
alias khelp='k api-resources'
alias kalias='alias | egrep kubectl'
alias kctx='kubectx'
alias kns='kubens'
alias osl='openssl x509 -text -noout -in'

# AZURE
alias azc="az account list  | jq -r '.[] | select(.isDefault == 'true') | .name'"




########################################################################
# AUTOCOMPLETION SCRIPTS
########################################################################

# AZ CLI
# wget https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion
autoload -U +X bashcompinit && bashcompinit


# Az cli completion
[ -f ~/.az.completion ] && source ~/.az.completion

# FZF Autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Helm completion (if file doesnt exists execute helm completion zsh > ~/auger/helm.completion )
[ -f ~/.config/helm.completion ] && source ~/.config/helm.completion

# Kubectl autocompletion (if file doesnt exists execute kubectl completion zsh > .config/kubectl.completion)
[ -f ~/.config/kubectl.completion ] && source ~/.config/kubectl.completion

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi





########################################################################
# FUNCTIONS
########################################################################

function kubectlgetall() {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl -n ${1} get --ignore-not-found ${i}
    echo ""
    echo "#############################################################"
    echo ""
    echo ""
  done
}


########################################################################
# HISTORY TIMESTAMP
########################################################################
export HISTTIMEFORMAT="%d/%m/%y %T "
export PATH="$HOME/.google-cloud-sdk/bin:$HOME/.tfenv/bin:${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Hisotry alias
alias th='history -E'

# Write to history immediatly
setopt inc_append_history
setopt share_history
setopt HIST_IGNORE_SPACE

# Hisotry size
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTFILE=~/.zhistory

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
