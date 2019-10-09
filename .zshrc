
#Terminal Set-up: Start using power line
function powerline_precmd() {
    eval "$($GOPATH/bin/powerline-go -error $? -shell zsh -colorize-hostname -eval -modules-right  git)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi
#Terminal Set-up: End using power line


#Oh-my-zsh: Start
export ZSH="/Users/khaledmosharrafmukut/.oh-my-zsh"
plugins=(git)

source $ZSH/oh-my-zsh.sh
#Oh-my-zsh: End


#Completions: start
fpath=(/usr/local/share/zsh-completions $fpath)
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
autoload -Uz compinit
compinit


#Directory help: start
setopt  autocd autopushd 
#Directory help: end

#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced #for dark theme
#export LSCOLORS=ExFxBxDxCxegedabagacad #for light theme

export HISTSIZE=10000
export HISTFILESIZE=120000

alias ls='ls -GFh'
alias ll='ls -FGlAhp'
#alias bash='. ~/.bash_profile'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -GA'
alias lh='ls -Gltrh'
cd() { builtin cd "$@"; ls; }  # Always list directory contents upon 'cd'
alias c='clear'                # Clear terminal display
mcd () { mkdir -p "$1" && cd "$1"; } #Makes new Dir and jumps inside

#go environment: Start
export GOPATH=/usr/local/bin/
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
#go environment: End

#FOLDER MANAGEMENT: Start
zipf () { zip -r -X "$1".zip "$1" ; } # zipf:To create a ZIP archive of a folder
#FOLDER MANAGEMENT: End

#   extract:  Extract most know archives with one command
   extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }
#   extract:  End


#Batman: Start
#cat ~/batman/batman_art_work/$(( RANDOM % (`ls -1U ~/batman/batman_art_work |wc -l`) + 1 ))
#Batman: End

#start: Random Quote
#artii -f small Welcome
fortune | cowsay -W 70 -f turtle| lolcat
#end: Random Quote



#Experiments with alias: Start
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias batman="cat ~/batman/batman_art_work/$(( RANDOM % (`ls -1U ~/batman/batman_art_work |wc -l`) + 1 ))"

#Experiment with alias: End