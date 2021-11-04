#Terminal Set-up: Start using power line
function powerline_precmd() {
    eval "$($GOPATH/bin/powerline-go -error $? -shell zsh -colorize-hostname  -eval -modules-right  git,ssh,time )"
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
plugins=(
  git
  cloudapp
  zsh-syntax-highlighting
  zsh-autosuggestions
 )
#export ZSH_THEME="powerlevel9k/powerlevel9k"
source $ZSH/oh-my-zsh.sh
ENABLE_CORRECTION="true"
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
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx #for black background
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd  #linux like


export HISTSIZE=10000
export HISTFILESIZE=120000

alias ls='ls -GFh'
alias ll='ls -FGlAhp'
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
tarf () { tar -c -f "$1".tar "$1" ; } # tarf: To create a TAR archive of a folder
#FOLDER MANAGEMENT: End

# Colorful CAT
cat() {
    local out colored
    out=$(/bin/cat $@)
    colored=$(echo $out | pygmentize -f console -g 2>/dev/null)
    [[ -n $colored ]] && echo "$colored" || echo "$out"
}
# Colorful 

# Colorful MAN

man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# Colorful MAN





#Python Set Up: Start
virtual () { python3 -m venv "$1";}

kernel () {virtual "$1"; source "$1"/bin/activate; pip install ipykernel; pip install --upgrade pip;
            python -m ipykernel install --user --name="$1";}
delete_kernel() {jupyter kernelspec uninstall "$1";}
#Python Set Up: End

#Mount Remote: Start
Mount(){
        printf "UserName:"
        read -r user
        printf "HostName:"
        read -r host 
        printf "nickName:"
        read -r name 
        sshfs $user@$host:./ $HOME/$name/ -ovolname=$name;
        }
#sshfs mukutk@hpc:/home/mukutk/ /Users/khaledmosharrafmukut/HPC -ovolname=HPC

#Mount Remote: End



#Youtube DL: Start

youtube_format () { youtube-dl --no-check-certificate -F  "$1";}

youtube_audio() {youtube-dl --no-check-certificate  -f bestaudio --audio-format mp3 -o '~/Music/youtube/%(title)s.%(ext)s' "$1"}

youtube_video() {youtube-dl --no-check-certificate -f  bestvideo+bestaudio -o '~/Music/youtube_Video/%(title)s.%(ext)s' "$1"}

youtube_small() {youtube-dl --ignore-errors --no-check-certificate -f  best "$1"}

mp3() {youtube-dl --ignore-errors --no-check-certificate -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '~/Music/youtube/%(title)s.%(ext)s' "$1"}

album() {youtube-dl --ignore-errors -f --no-check-certificate bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '~/Music/youtube/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "$1"}

mp4() {youtube-dl --no-check-certificate --ignore-errors --format  "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 -o '~/Music/youtube_Video/%(title)s.%(ext)s' "$1"}

server() {youtube-dl --no-check-certificate --ignore-errors --format  "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 -o '/Volumes/Media/%(title)s.%(ext)s' "$1"}

#Youtube DL: End


#compress video
compress(){ffmpeg -i $1 -vcodec libx264 -crf 20 output_$1}
#compress video

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


#Batman: Start
batman () { lolcat ~/batman/batman_art_work/$(( RANDOM % (`ls -1U ~/batman/batman_art_work |wc -l`) + 1 )) ;} 
#cat ~/batman/batman_art_work/$(( RANDOM % (`ls -1U ~/batman/batman_art_work |wc -l`) + 1 ))
#Batman: End

#start: Random Quote
#artii -f small Welcome
#fortune | cowsay -W 70 -f turtle| lolcat
archey
#end: Random Quote

#Experiments with alias function: Start

# Searches for text in all files in the current folder
ftext ()
{
  # -i case-insensitive
  # -I ignore binary files
  # -H causes filename to be printed
  # -r recursive search
  # -n causes line number to be printed
  # optional: -F treat search term as a literal, not a regular expression
  # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
  grep -iIHrn --color=always "$1" . | less -r
}


#wget with resume: Start
#alias wget = 'wget -c'
#wget with resume: END

# Copy and go to the directory
cpg ()
{
  if [ -d "$2" ];then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

# Move and go to the directory
mvg ()
{
  if [ -d "$2" ];then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}


# Goes up a specified number of directories  (i.e. up 4)
up ()
{
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}





#Copy with progress bar using PV: Start

function cpv()
{
  local DST=${@: -1}                    # last element
  local SRC=( ${@: 1 : $# - 1} )        # array with rest of elements

  # checks
  type pv &>/dev/null || { echo "install pv first"; return 1; }
  [ $# -lt 2  ]       && { echo "too few args"    ; return 1; }

  # special invocation
  function cpv_rename()
  {
    local SRC="$1"
    local DST="$2"
    local DSTDIR="$( dirname "$DST" )"

    # checks
    if   [ $# -ne 2     ]; then echo "too few args"          ; return 1; fi
    if ! [ -e "$SRC"    ]; then echo "$SRC doesn't exist"    ; return 1; fi
    if   [ -d "$SRC"    ]; then echo "$SRC is a dir"         ; return 1; fi
    if ! [ -d "$DSTDIR" ]; then echo "$DSTDIR does not exist"; return 1; fi

    # actual copy
    echo -e "\n$SRC 🡺  $DST"
    pv   "$SRC" >"$DST"
  }

  # special case for cpv_rename()
  if ! [ -d "$DST" ]; then cpv_rename "$@"; return $?; fi;

  # more checks
  for src in "${SRC[@]}"; do 
    local dst="$DST/$( basename "$src" )"
    if ! [ -e "$src" ]; then echo "$src doesn't exist" ; return 1;
    elif [ -e "$dst" ]; then echo "$dst already exists"; return 1; fi
  done

  # actual copy
  for src in "${SRC[@]}"; do 
    if ! [ -d "$src" ]; then 
      local dst="$DST/$( basename "$src" )"
      echo -e "\n$src 🡺  $dst"
      pv "$src" > "$dst"
    else 
      local dir="$DST/$( basename "$src" )"
      mkdir "$dir" || continue
      local srcs=( $src/* )
      cpv "${srcs[@]}" "$dir";
    fi
  done
  unset cpv_rename
}

compile_omp(){/usr/local/opt/llvm/bin/clang -fopenmp -L/usr/local/opt/llvm/lib $1 -o omp_$1}


#python standalone: start
executable () { python -O -m PyInstaller --onefile "$1";}
#python standalone: stop

#Copy with progress bar using PV: END

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip
# pip zsh completion end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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


export PATH="/usr/local/opt/texinfo/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/Users/khaledmosharrafmukut/.gem/ruby/2.6.0/bin:$PATH"

  export GUILE_LOAD_PATH="/usr/local/share/guile/site/3.0"
  export GUILE_LOAD_COMPILED_PATH="/usr/local/lib/guile/3.0/site-ccache"
  export GUILE_SYSTEM_EXTENSIONS_PATH="/usr/local/lib/guile/3.0/extensions"

 [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.shexport PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
# export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"
# export PATH="/usr/local/opt/llvm/bin:$PATH"
