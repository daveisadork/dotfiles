#!/usr/local/bin/zsh

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

STATUS_OUTPUT=
PMSET="$(pmset -g batt)"
PERCENTAGE="$(echo \"$PMSET\"| grep -op '\(1\?[0-9]\{1,2\}\%\)')"
echo $PMSET | grep -q 'AC Power'
if [ $? -eq 0  ]
then
    AC_POWER=1
    echo $PMSET | grep -q 'charging'
    if [ $? -eq 0  ]
    then
        CHARGING=1
    else
        CHARGING=0
    fi
else
    AC_POWER=0
fi

BG_COLOR=$BASE02
if [ $AC_POWER -eq 1 ]
then
    TEXT_FG_COLOR=$BASE00
    if [ $CHARGING -eq 1 ]
    then
        CHARGE_FG_COLOR=$ORANGE
    else
        CHARGE_FG_COLOR=$GREEN
    fi
    STATUS_OUTPUT="$STATUS_OUTPUT#[fg=$CHARGE_FG_COLOR,bg=$BASE02,nobold,nounderscore,noitalics]●"
else
    echo $PMSET | grep -q 'Battery Warning'
    if [ $? -eq 0 ]
    then
        echo $PMSET | grep -q 'Battery Warning: Final'
        if [ $? -eq 0 ]
        then
            BG_COLOR=$RED
            TEXT_FG_COLOR=$BASE3
        else
            TEXT_FG_COLOR=$RED
        fi
    else
        NUMBER="$(echo $PERCENTAGE | grep -op '[0-9]\+')"
        if [ $NUMBER -lt 20 ]
        then
            TEXT_FG_COLOR=$MAGENTA
        elif [ $NUMBER -lt 40 ]
        then
            TEXT_FG_COLOR=$VIOLET
        elif [ $NUMBER -lt 60 ]
        then
            TEXT_FG_COLOR=$BLUE
        elif [ $NUMBER -lt 80 ]
        then
            TEXT_FG_COLOR=$CYAN
        else
            TEXT_FG_COLOR=$BASE01
        fi
    fi
fi

STATUS_OUTPUT="$STATUS_OUTPUT#[fg=$TEXT_FG_COLOR,bg=$BG_COLOR,nobold,nounderscore,noitalics]$PERCENTAGE"

echo $STATUS_OUTPUT
