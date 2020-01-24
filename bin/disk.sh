#!/usr/bin/env sh

# BASE03=colour8
# BASE02=colour0
# BASE01=colour10
# BASE00=colour11
# BASE0=colour12
# BASE1=colour14
# BASE2=colour7
# BASE3=colour15
# YELLOW=colour3
# ORANGE=colour9
# RED=colour1
# MAGENTA=colour5
# VIOLET=colour13
# BLUE=colour4
# CYAN=colour6
# GREEN=colour2

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




DF="$(gdf -h -l --output=avail,pcent,target . | grep -E '/$')"
NUMBER="$(echo \"$DF\"| grep -oE '(1?[0-9]{2}%)' | grep -oE '[0-9]+')"
DISK_FREE="$(echo \"$DF\"| grep -oE '([0-9.]*[KMGTPEZY])')"

if [[ $NUMBER -ge 90 ]]
then
    TEXT_FG_COLOR="red"
elif [[ $NUMBER -ge 80 ]]
then
    TEXT_FG_COLOR="colour4"
elif [[ $NUMBER -ge 60 ]]
then
    TEXT_FG_COLOR="yellow"
elif [[ $NUMBER -ge 40 ]]
then
    TEXT_FG_COLOR="green"
elif [[ $NUMBER -ge 20 ]]
then
    TEXT_FG_COLOR="blue"
else
    TEXT_FG_COLOR="white"
fi

echo "#[fg=$TEXT_FG_COLOR,nobold,nounderscore,noitalics]$DISK_FREE#[fg=colour8,nobold,nounderscore,noitalics]"
