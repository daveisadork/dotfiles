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

DF="$(df -h -l --output=avail,pcent,target . | grep -E '/$')"
NUMBER="$(echo \"$DF\"| grep -oE '(1?[0-9]{2}%)' | grep -oE '[0-9]+')"
DISK_FREE="$(echo \"$DF\"| grep -oE '([0-9.]*[KMGTPEZY])')"

if [[ $NUMBER -ge 90 ]]
then
    TEXT_FG_COLOR=$RED
elif [[ $NUMBER -ge 80 ]]
then
    TEXT_FG_COLOR=$MAGENTA
elif [[ $NUMBER -ge 60 ]]
then
    TEXT_FG_COLOR=$VIOLET
elif [[ $NUMBER -ge 40 ]]
then
    TEXT_FG_COLOR=$BLUE
elif [[ $NUMBER -ge 20 ]]
then
    TEXT_FG_COLOR=$CYAN
else
    TEXT_FG_COLOR=$BASE01
fi

echo "#[fg=$TEXT_FG_COLOR,bg=$BASE02,nobold,nounderscore,noitalics]$DISK_FREE#[fg=$BASE00,bg=$BASE02,nobold,nounderscore,noitalics]"
