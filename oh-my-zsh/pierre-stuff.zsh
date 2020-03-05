export ZSH_THEME="bira"

export EDITOR="vim"
export TERM="xterm-256color"

export PATH="/usr/lib/ccache:$PATH"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

source /usr/share/autojump/autojump.sh
