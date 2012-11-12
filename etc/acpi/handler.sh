#!/bin/sh

case "$1" in
    button*)
        case "$2" in
            LID)
                systemctl start slimlock.service
                systemctl start tmuxlock.service
                /etc/acpi/actions/toggle_dpms.sh
                ;;
        esac
        ;;
    hotkey)
        case "$3" in
            0000005c)
                systemctl start slimlock.service
                systemctl start tmuxlock.service
                ;;
        esac
        ;;
esac
