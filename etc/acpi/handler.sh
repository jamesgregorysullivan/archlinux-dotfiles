#!/bin/sh

case "$1" in
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
        esac
        ;;
esac
