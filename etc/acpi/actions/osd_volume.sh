#!/bin/sh

VOLUME=`amixer get Master | grep 'Mono: Playback' | awk '{$vol=substr($4,2); i=index($vol,"%"); $vol=substr($vol,1,i-1); print $vol}'`

amixer get Master,0 |grep 'Mono: Playback' |grep -F [on] >/dev/null
if [ "$?" -ne 0 ]; then
    COLOUR="red"
    VOLUME="0"
else
    COLOUR="green"
fi

osd_cat -o 700 -A center -f -misc-fixed-medium-r-semicondensed--*-180-*-*-c-*-*-* -d 2 -b percentage -P $VOLUME -c $COLOUR -T "Volume: $VOLUME%"&
VOLUME_PID=$!
VOLUME_PID2=`cat /tmp/osd.pid`
echo $VOLUME_PID > /tmp/osd.pid
kill $VOLUME_PID2 1>/dev/null 2>&1
