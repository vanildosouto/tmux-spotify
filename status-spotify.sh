#!/bin/bash

status="STOPPED"

if [ "$(pidof spotify)" ]; then
    status=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus'|egrep -A 1 "string"|cut -b 26-|cut -d '"' -f 1|egrep -v ^$`
    artist=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 2 "artist"|egrep -v "artist"|egrep -v "array"|cut -b 27-|cut -d '"' -f 1|egrep -v ^$`
    title=`dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'|egrep -A 1 "title"|egrep -v "title"|cut -b 44-|cut -d '"' -f 1|egrep -v ^$`
else
    if [ "$(pidof cmus)" ]; then
        artist=`cmus-remote -Q | grep " artist " | cut -d ' ' -f 3-`
        title=`cmus-remote -Q | grep title | cut -d ' ' -f 3-`
    else
        echo "♫ STOPPED"
        exit
    fi
fi

artist_size=${#artist}
title_size=${#title}
prefix=""

if [ $status = "Playing" ]; then
    prefix=""
else
    if [ $status = "Paused" ]; then
        prefix=""
    fi
fi

if [ $artist_size -ge 20 ]; then
    artist="${artist:0:17}...";
fi

if [ $title_size -ge 20 ]; then
    title="${title:0:17}...";
fi

status="${prefix} ${artist} - $title"

echo "♫ $status"
