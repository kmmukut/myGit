#!/bin/bash

# NAME: now
# PATH: $HOME/bin
# DESC: Display current weather, calendar and time
# CALL: Called from terminal or ~/.bashrc
# DATE: Apr 6, 2017. Modified: May 24, 2019.

# UPDT: 2019-05-24 If Weather unavailable nicely formatted error message.

# NOTE: To display all available toilet fonts use this one-liner:
#       for i in ${TOILET_FONT_PATH:=/usr/share/figlet}/*.{t,f}lf; do j=${i##*/}; toilet -d "${i%/*}" -f "$j" "${j%.*}"; done

# Setup for 92 character wide terminal
DateColumn=34 # Default is 27 for 80 character line, 34 for 92 character line
TimeColumn=61 # Default is 49 for   "   "   "   "    61 "   "   "   "

# Replace location with your city name, GPS, etc. See: curl wttr.in/:help
location=Milwaukee
curl wttr.in/${location}?0mM --silent --max-time 3 > /tmp/now-weather
# Timeout #. Increase for slow connection---^

readarray aWeather < /tmp/now-weather
rm -f /tmp/now-weather

# Was valid weather report found or an error message?
if [[ "${aWeather[0]}" == "Weather report:"* ]] ; then
    WeatherSuccess=true
    echo "${aWeather[@]}"
else
    WeatherSuccess=false
    echo "+============================+"
    echo "| Weather unavailable now!!! |"
    echo "| Check reason with command: |"
    echo "|                            |"
    echo "| curl wttr.in/location?0    |" # Replace Edmonton with your city
    echo "|   --silent --max-time 3    |"
    echo "+============================+"
    echo " "
fi
echo " "                # Pad blank lines for calendar & time to fit

#--------- DATE -------------------------------------------------------------

# calendar current month with today highlighted.
# colors 00=bright white, 31=red, 32=green, 33=yellow, 34=blue, 35=purple,
#        36=cyan, 37=white

tput sc                 # Save cursor position.
# Move up 9 lines
i=0
while [ $((++i)) -lt 10 ]; do tput cuu1; done

if [[ "$WeatherSuccess" == true ]] ; then
    # Depending on length of your city name and country name you will:
    #   1. Comment out next three lines of code. Uncomment fourth code line.
    #   2. Change subtraction value and set number of print spaces to match
    #      subtraction value. Then place comment on fourth code line.
    Column=$((DateColumn - 10))
    tput cuf $Column        # Move x column number
    # Blank out ", country" with x spaces
    printf "          "
else
    tput cuf $DateColumn    # Position to column 27 for date display
fi

# -h needed to turn off formating: https://askubuntu.com/questions/1013954/bash-substring-stringoffsetlength-error/1013960#1013960
cal > /tmp/terminal1
# -h not supported in Ubuntu 18.04. Use second answer: https://askubuntu.com/a/1028566/307523
tr -cd '\11\12\15\40\60-\136\140-\176' < /tmp/terminal1  > /tmp/terminal

CalLineCnt=1
Today=$(date +"%e")

printf "\033[33m"   # color green -- see list above.

while IFS= read -r Cal; do
    printf "%s" "$Cal"
    if [[ $CalLineCnt -gt 2 ]] ; then
        # See if today is on current line & invert background
        tput cub 22
        for (( j=0 ; j <= 18 ; j += 3 )) ; do
            Test=${Cal:$j:2}            # Current day on calendar line
            if [[ "$Test" == "$Today" ]] ; then
                printf "\033[7m"        # Reverse: [ 7 m
                printf "%s" "$Today"
                printf "\033[0m"        # Normal: [ 0 m
                printf "\033[33m"       # color green -- see list above.
                tput cuf 1
            else
                tput cuf 3
            fi
        done
    fi

    tput cud1               # Down one line
    tput cuf $DateColumn    # Move 27 columns right
    CalLineCnt=$((++CalLineCnt))
done < /tmp/terminal

printf "\033[00m"           # color -- bright white (default)
echo ""

tput rc                     # Restore saved cursor position.

#-------- TIME --------------------------------------------------------------

tput sc                 # Save cursor position.
# Move up 8 lines
i=0
while [ $((++i)) -lt 9 ]; do tput cuu1; done
tput cuf $TimeColumn    # Move 49 columns right

# Do we have the toilet package?
if hash toilet 2>/dev/null; then
    echo " $(date +"%I:%M %P") " | \
        toilet -f future --filter border > /tmp/terminal
# Do we have the figlet package?
elif hash figlet 2>/dev/null; then
#    echo $(date +"%I:%M %P") | figlet > /tmp/terminal
    date +"%I:%M %P" | figlet > /tmp/terminal
# else use standard font
else
#    echo $(date +"%I:%M %P") > /tmp/terminal
    date +"%I:%M %P" > /tmp/terminal
fi

while IFS= read -r Time; do
    printf "\033[01;32m"    # color green
    printf "%s" "$Time"
    tput cud1               # Up one line
    tput cuf $TimeColumn    # Move 49 columns right
done < /tmp/terminal

tput rc                     # Restore saved cursor position.

exit 0