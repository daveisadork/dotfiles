#!/opt/homebrew/bin/zsh

#BASE03=colour8
#BASE02=colour0
#BASE01=colour10
#BASE00=colour11
#BASE0=colour12
#BASE1=colour14
#BASE2=colour7
#BASE3=colour15
#YELLOW=colour3
#ORANGE=colour9
#RED=colour1
#MAGENTA=colour5
#VIOLET=colour13
#BLUE=colour4
#CYAN=colour6
#GREEN=colour2

BASE03="#002b36"
BASE02="#073642"
BASE01="#586e75"
BASE00="#657b83"
BASE0="#839496"
BASE1="#93a1a1"
BASE2="#eee8d5"
BASE3="#fdf6e3"
YELLOW="#b58900"
ORANGE="#cb4b16"
RED="#dc322f"
MAGENTA="#d33682"
VIOLET="#6c71c4"
BLUE="#268bd2"
CYAN="#2aa198"
GREEN="#859900"

# STATUS_OUTPUT="#[fg=colour8] "
STATUS_OUTPUT=
PMSET="$(pmset -g batt)"
PERCENTAGE="$(echo \"$PMSET\"| grep -op '\(1\?[0-9]\{1,2\}\%\)')"
NOT_CHARGING=0
echo $PMSET | grep -q 'AC Power'
if [ $? -eq 0  ]
then
    AC_POWER=1
    echo $PMSET | egrep -q '(finishing charge|charging)'
    if [ $? -eq 0  ]
    then
        CHARGING=1
        echo $PMSET | egrep -q 'not charging'
        if [ $? -eq 0 ]
        then
          NOT_CHARGING=1
        fi
    else
        CHARGING=0
    fi
else
    AC_POWER=0
fi

BG_COLOR="colour0"
if [ $AC_POWER -eq 1 ]
then
    if [ $NOT_CHARGING -eq 1 ]
    then
      TEXT_FG_COLOR="yellow"
    else
      TEXT_FG_COLOR="#939293"
    fi
    if [ $CHARGING -eq 1 ]
    then
        CHARGE_FG_COLOR="blue"
    else
        CHARGE_FG_COLOR="green"
    fi
    STATUS_OUTPUT="$STATUS_OUTPUT#[fg=$CHARGE_FG_COLOR]●"
else
    echo $PMSET | grep -q 'Battery Warning'
    if [ $? -eq 0 ]
    then
        echo $PMSET | grep -q 'Battery Warning: Final'
        if [ $? -eq 0 ]
        then
            STATUS_OUTPUT="#[fg=red]#[bg=red] "
            TEXT_FG_COLOR="white"
        else
            TEXT_FG_COLOR="red"
        fi
    else
        NUMBER="$(echo $PERCENTAGE | grep -op '[0-9]\+')"
        if [ $NUMBER -lt 20 ]
        then
            TEXT_FG_COLOR="blue"
        elif [ $NUMBER -lt 40 ]
        then
            TEXT_FG_COLOR="yellow"
        elif [ $NUMBER -lt 60 ]
        then
            TEXT_FG_COLOR="green"
        elif [ $NUMBER -lt 80 ]
        then
            TEXT_FG_COLOR="cyan"
        else
            TEXT_FG_COLOR="#939293"
        fi
    fi
fi

# STATUS_OUTPUT="$STATUS_OUTPUT#[fg=$TEXT_FG_COLOR,nobold,nounderscore,noitalics]$PERCENTAGE #[fg=colour0]#[bg=colour0]"
STATUS_OUTPUT="$STATUS_OUTPUT#[fg=$TEXT_FG_COLOR,nobold,nounderscore,noitalics]$PERCENTAGE"

# for COLOR in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
# do 
#   STATUS_OUTPUT="$STATUS_OUTPUT #[fg=colour8,bg=colour$COLOR,nobold,nounderscore,noitalics]$COLOR"
# done

echo $STATUS_OUTPUT
