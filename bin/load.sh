#!/usr/bin/env zsh

BASE03=colour8
BASE02=colour0
BASE01=colour10
BASE00=colour11
BASE0=colour12
BASE1=colour14
BASE2=colour7
BASE3=colour15
YELLOW=colour3
ORANGE=colour9
RED=colour1
MAGENTA=colour5
VIOLET=colour13
BLUE=colour4
CYAN=colour6
GREEN=colour2

if [ -r "/proc/loadavg" ]
then
    read ONE OTHER < /proc/loadavg
else
    ONE=$(uptime | sed -e "s/.*://" | awk '{print $1}')
fi
CORES=$(nproc)
if [ -n "$ONE" ]
then
    ((ADJUSTED=$ONE/$CORES))
    if [[ $ADJUSTED -ge 0.9 ]]
    then
        TEXT_FG_COLOR=$RED
    elif [[ $ADJUSTED -ge 0.8 ]]
    then
        TEXT_FG_COLOR=$MAGENTA
    elif [[ $ADJUSTED -ge 0.6 ]]
    then
        TEXT_FG_COLOR=$VIOLET
    elif [[ $ADJUSTED -ge 0.4 ]]
    then
        TEXT_FG_COLOR=$BLUE
    elif [[ $ADJUSTED -ge 0.2 ]]
    then
        TEXT_FG_COLOR=$CYAN
    else
        TEXT_FG_COLOR=$BASE01
    fi
    echo "#[fg=$TEXT_FG_COLOR,bg=$BASE02,nobold,nounderscore,noitalics]$ONE#[fg=$BASE00,bg=$BASE02,nobold,nounderscore,noitalics]"
fi
