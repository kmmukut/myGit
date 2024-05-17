
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="agnoster"

alias now='bash ~/Powerline-go/now.sh'

# Set time, weather and system block: Start --> requires neofetch
now
# neofetch
# Set time, weather and system block: Stop

#POWERLINE:start


function powerline_precmd() {
    PS1="$($HOME/Powerline-go/powerline-go -error $? -shell zsh)"
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


#POWERLINE:end

# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git
          zsh-syntax-highlighting
          fast-syntax-highlighting
        #   zsh-autocomplete
          zsh-autosuggestions
          z
          )


source $ZSH/oh-my-zsh.sh
ENABLE_CORRECTION="true"


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


export HISTSIZE=10000
export HISTFILESIZE=120000

alias ls='ls -GFh --color'
alias ll='ls -FGlAhp --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -GA'
alias lh='ls -Gltrh'
cd() { builtin cd "$@"; ls; }  # Always list directory contents upon 'cd'
alias c='clear'                # Clear terminal display
mcd () { mkdir -p "$1" && cd "$1"; } #Makes new Dir and jumps inside


#FOLDER MANAGEMENT: Start
zipf () { zip -r -X "$1".zip "$1" ; } # zipf:To create a ZIP archive of a folder
tarf () { tar -c -f "$1".tar "$1" ; } # tarf: To create a TAR archive of a folder
#FOLDER MANAGEMENT: End

#compress video
compress(){ffmpeg -i $1 -vcodec libx264 -crf 20 output_$1}
#compress video

# CLI Weather: Start
getWeather(){curl wttr.in/$1}
compareWeather(){diff -Naur <(curl -s http://wttr.in/$1 ) <(curl -s http://wttr.in/$2 )}
# CLI Weather: End

#Git Latex
gitHash(){git rev-parse --short $1}
pdfDiff(){git latexdiff --latexmk --ignore-latex-errors --ignore-makefile  --quiet --main main.tex  -o diff.pdf $1  $2}
showDiffPdf(){OLD=$(gitHash $1) ; NEW=$(gitHash $2) ; pdfDiff $OLD $NEW; mv diff.pdf diff_$1_$2.pdf; open diff_$1_$2.pdf}
#Git Latex

#   extract:  Extract most know archives with one command
   extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.tar.xz)    tar Jxvf $1    ;;
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


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/kmmukut/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/kmmukut/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kmmukut/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kmmukut/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kmmukut/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kmmukut/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
