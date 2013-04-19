## environment variables
export COLORFGBG=default,default,default    # I think tmux sets this wrong

# for GTK styles in Qt
export GTK2_RC_FILES=$HOME/.gtkrc-2.0

# gpg-agent sockets
if [ -f /run/user/1000/gpg-agent-info ]; then
    source /run/user/1000/gpg-agent-info
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi

# socket paths
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/dbus/user_bus_socket   # temporal fix until systemd sets this automatically (or until this is the default path for dbus)
export RXVT_SOCKET=$XDG_RUNTIME_DIR/urxvtd-socket