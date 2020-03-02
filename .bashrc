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

#Terminal Set-up: Start using power line
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $? -shell bash -colorize-hostname)"
}

if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
#Terminal Set-up: End

#bash completion: Start
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}
#bash completion: End
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




# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 2>/dev/null ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

