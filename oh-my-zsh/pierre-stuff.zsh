export ZSH_THEME="bira"

export EDITOR="vim"
export TERM="xterm-256color"

export PATH="/usr/lib/ccache:$PATH"
export PATH="$PATH:/home/pierre/.local/bin"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

source /usr/share/autojump/autojump.sh

# Aliases and functions
alias n="nautilus . &"

# Usage: not <time after which to send the notification> <notification message>
not() {
    (sleep $1; notify-send $2) &
}

# Disassemble a binary
disassemble() {
    f=`mktemp /tmp/$1-XXX-disassembled.txt`
    objdump --source $1 > $f
    vim $f
}
