#added# on Mac put to ~/.zshrc

export PATH=$PATH:/bin/
export PATH=$PATH:/usr/bin/
export PATH=$PATH:/usr/local/go/bin/
export PATH=$PATH:/usr/local/bin/
export PATH=$PATH:~/go/bin/
#export PATH=$PATH:/usr/local/projects/bin/
export PATH=$PATH:/home/chen/pycharm-2016.2.3/bin 
export PATH=$PATH:/usr/local/projects/flutter/bin/
export PATH=/usr/local/opt/make/libexec/gnubin:$PATH
export PKG_CONFIG_PATH=/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH 
export PATH=$PATH:/usr/local/projects/bin/x86-64--glibc--bleeding-edge-2025.08-1/

HISTSIZE=1000000  # set history commands acount
HISTFILESIZE=1000000
HISTCONTROL=ignoreboth:erasedups # filter duplicate history commands

set -o vi                          # set shell in vi model
export VISUAL=vim                  # set default vim
export EDITOR="$VISUAL"
export GO111MODULE=on              # enable golang module
#export GOPROXY=https://goproxy.io  # set golang proxy
export CGO_ENABLED=0               # not ust c lib but pure go 

alias vi='vim'
alias c='clear'
alias h='history | grep '
alias ls='ls --show-control-chars' # for ls show chinese file name currect
alias ls='ls'    # MAC for ls as ls
alias ll='ls -1' # MAC for has no ll
alias fs='du -cksh * | sort -rn | head -100' # show file size
alias share='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"' # share current folder file ctr_c to stop 
alias wn="watch -n1 \"netstat -ant|awk '{print \\\$6}' |sort|uniq -c|sort -nr\""
# proxy
alias proxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
alias unproxy='export https_proxy= http_proxy= all_proxy='
# git
#alias add="git add --all ."
#alias commit="git commit -am 'update'"
#alias pull="git pull --rebase -v origin main || git pull --rebase -v origin master"
alias pull="git pull --autostash origin main || git pull --autostash origin master"
alias push="git push --autostash origin main || git push --autostash origin master"
#alias p="add && commit && push"
#alias cm='git add --all . ; git commit -am "update" ; git pull --rebase -v origin main ; git push -v origin HEAD:main' 
#alias cm='B=$(git branch --show-current); git add --all . ; git commit -am "update" ; git pull -v origin $B ; git push -v origin $B' 
#alias cm='git add --all . ; git commit -am "update" ; git pull -v origin main ; git push -v origin HEAD:main' 
cm() {
    local msg="${*:-update}"
    git add --all . && \
    if ! git diff --cached --quiet; then
        git commit -m "$msg"
    fi
    git pull -v origin main && \
    git push -v origin HEAD:main
}
 
# note
alias jn="vim + /usr/local/projects/note/note.txt"
alias jp='vim + /usr/local/projects/pass/pass.txt'
#alias rp='cd /usr/local/projects/pass && pull && cm && cd -'
#alias rn='cd /usr/local/projects/note && pull && cm && cd -'
rn () { cd /usr/local/projects/note || return; pull; cm "$@"; cd - > /dev/null;}
rp () { cd /usr/local/projects/pass || return; pull; cm "$@"; cd - > /dev/null;}

#alias sshaws='ssh -o ServerAliveInterval=20 -o ConnectTimeout=20 -i ~/.ssh/ccc.pem ec2-user@ec2-13-42-66-167.eu-west-2.compute.amazonaws.com'
#alias tb="sed 's/[- ]*\([+|]\)/'$'\x01''\1/g' | column -ts $'\x01' | sed '/^[-+ ]*$/s/ /-/g'" # table align
                      
# for golang tview show first character correctly
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"




export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/chengang/.bun/_bun" ] && source "/Users/chengang/.bun/_bun"
