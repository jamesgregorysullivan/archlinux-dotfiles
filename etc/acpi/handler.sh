#!/bin/sh

DBUS=$(ps aux | grep 'dbus-launch' | grep -v root)
if [[ ! -z $DBUS ]];then
    USER=$(echo $DBUS | awk '{print $1}')
    USERHOME=$(getent passwd $USER | cut -d: -f6)
    export XAUTHORITY="$USERHOME/.Xauthority"
    for x in /tmp/.X11-unix/*; do
        DISPLAYNUM=$(echo $x | sed s#/tmp/.X11-unix/X##)
        if [[ -f "$XAUTHORITY" ]]; then
            export DISPLAY=":$DISPLAYNUM"
        fi
    done
fi

case "$1" in
    hotkey)
        case "$2" in
            ATK0100:00)
                case "$3" in
                    0000006b)
                        /etc/acpi/actions/toggle_touchpad.sh
                        ;;
                esac
                ;;
        esac
        ;;
    button*)
        case "$2" in
            LID)
                systemctl start slimlock.service
                systemctl start tmuxlock.service
                /etc/acpi/actions/toggle_dpms.sh
                ;;
            SCRNLCK)
                systemctl start slimlock.service
                systemctl start tmuxlock.service
                ;;
#            WLAN)
#                systemctl start rfkill.service
#                ;;
        esac
        ;;
    cd*)
        case "$2" in
            CDPLAY)
                mpc toggle
                ;;
            CDSTOP)
                mpc stop
                ;;
            CDPREV)
                mpc prev
                ;;
            CDNEXT)
                mpc next
                ;;
        esac
        ;;
    video*)
        case "$2" in
            BRTUP|BRTDN)
                su lahwaacz -c "/etc/acpi/actions/display-brightness-notify.py"
                ;;
        esac
        ;;
esac
