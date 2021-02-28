# .zshrc

# Source global definitions
if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi

# Use conda associated to a recent python
. /opt/anaconda3//lib/python3.7/site-packages/conda/shell/etc/profile.d/conda.sh
conda activate

#Searching and bell
#set bell-style none
#if [[ $- == *i* ]]
#then
#    bindkey "^[[A" history-search-backward
#    bindkey "^[[B" history-search-forward
#fi

# Easy directory navigation: no need for cd; - to go backl; dirs -v to see must used dirs; ~4 to go to number four.
setopt  autocd autopushd \ pushdignoredups
# Smart Tab completion
autoload -U compinit
compinit
# No bell
unsetopt BEEP

# Welcome and ALIASES
echo "Today is: `date`. Enjoy your session, Luca!"
autoload -U colors && colors
PS1="%{$fg[red]%}%~ %{$reset_color%} "
pi="ssh -X -Y  pi@192.168.0.100" #Our Raspberry PI
alias ll="ls -ltrh"
alias ls="ls -h"
alias h="history"
alias rm="rm -i"
alias ssh="ssh -XY"
alias d="dirs -v | awk '!seen[$2]++' | head -n 10"

# EXTRA
function last_two_dirs {
pwd |rev| awk -F / '{print $1,$2}' | rev | sed s_\ _/_
}

##############################################################################
# History Configuration
##############################################################################
#HISTSIZE=5000               #How many lines of history to keep in memory
#HISTFILE=~/.zsh_history     #Where to save history to disk
#SAVEHIST=5000               #Number of history entries to save to disk
##HISTDUP=erase               #Erase duplicates in the history file
#setopt appendhistory        #Append history to the history file (no overwriting)
#setopt sharehistory         #Share history across terminals
#setopt incappendhistory     #Immediately append to the history file, not just when a term is killed
#setopt INC_APPEND_HISTORY
#setopt EXTENDED_HISTORY
#setopt HIST_FIND_NO_DUPS
#export HISTTIMEFORMAT="[%F %T] "

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
