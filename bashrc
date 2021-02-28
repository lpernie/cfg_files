# .bashrc

# PYSPARK 
export JAVA_HOME=$(/usr/libexec/java_home)
#export SPARK_HOME=/Users/luca/Applications/spark-3.0.0-bin-hadoop2.7/    #! CAN BE REMOVED
#export PATH=$SPARK_HOME/bin:$PATH     #! CAN BE REMOVE
#export PYSPARK_PYTHON=python3 #! CAN BE REMOVE 
#export PATH="$HOME/.local/bin:$PATH" #! CAN BE REMOVE

#. /opt/anaconda3//lib/python3.7/site-packages/conda/shell/etc/profile.d/conda.sh   #! CAN BE REMOVE
#conda activate   #! CAN BE REMOVE

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
#Searching and bell
set bell-style none
if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi
# Welcome and ALIASES
echo "Today is: `date`. Enjoy your session, Luca!"
PS1='\[\033[01;32m\]\u \[\033[01;34m\] [\W]\[\033[00m\]'
pi="ssh -X -Y  pi@192.168.0.100" #Our Raspberry PI
shopt -s expand_aliases  #estend alias to all script
alias ll="ls -ltrh"
alias ls="ls -h"
alias root="root -l"
alias h="history"
alias rm="rm -i"
alias ssh="ssh -XY"
alias latex="/usr/texbin/latex"
alias makeindex="/usr/texbin/makeindex"
alias keras='cd /Users/Luca2/Documents/TAMU/Programming/Keras/Keras_Tutorial'

# EXTRA
function last_two_dirs {
pwd |rev| awk -F / '{print $1,$2}' | rev | sed s_\ _/_
}
