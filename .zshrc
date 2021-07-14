autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

export PATH=$PATH:$HOME/.local/bin:$HOME/bin
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;t:mtpmount;v:imgview;g:organize;r:launcher'
export NNN_FIFO=/tmp/nnn.fifo
export VISUAL=nvim
export EDITOR="$VISUAL"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk/jre'
export PATH=$JAVA_HOME/bin:$PATH 
export _JAVA_AWT_WM_NONREPARENTING=1
export ANDROID_SDK_ROOT='/opt/android-sdk'
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
export CHROME_EXECUTABLE="/usr/bin/google-chrome-unstable"
export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
NPM_PACKAGES="${HOME}/.npm-packages"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
export PATH=~/.npm-packages/bin:$PATH



###########
# GENERAL #
########### 
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#FF00FF"
#ENABLE_CORRECTION="true"
export UPDATE_ZSH_DAYS=7
setopt notify
setopt auto_cd # cd by typing directory name if it's not a command
##setopt correct_all # autocorrect commands
setopt auto_menu # automatically use menu completion
# End of lines 

###########
# PLUGINS #
########### 
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# End of lines

###############
# compinstall #
###############
zmodload -i zsh/complist
zstyle :compinstall filename '/home/katzeyurei/.zshrc'

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

if [[ "$OSTYPE" = solaris* ]]; then
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm"
else
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"
fi

# End of lines added by compinstall

##########
# CURSOR #
##########
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
# End of lines
# # ORDER

# USER

# HOST
# Result will look like this:
#   username@:(hostname)

#########
# ALIAS #
#########
alias vi="nvim"
alias nf="fzf | xargs -r nvim"
alias nn="nnn -de"
alias wclass="xprop | awk '/WM_CLASS/{print $4}'"
alias lf="lfrun"
alias cex="chmod +x"
alias win32="env PULSE_LATENCY_MSEC=40 WINEPREFIX=$HOME/.wine32 wine"
alias pc="sudo pacman"
alias ymst="yadm status"
alias ymadd="yadm add"
alias ymcom="yadm commit -m"
alias ymp="yadm push"
alias ls="ls --color=auto"
alias pcs="sudo pacman -S"
alias pcsyu="sudo pacman -Syu"
alias pcrcns="sudo pacman -Rcns"
alias pcr="sudo pacman -R"
alias gcl="git clone"
alias ga="git add"
alias gcmsg="git commit -m"
alias gp="git push"
# End of lines

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(starship init zsh)"
