#!/bin/bash

# Exit and reset on interrupt
trap "tput reset; tput cnorm; exit" 2

# Clear screen and hide cursor
clear
tput civis

# Initial tree position and settings
lin=2
col=$(($(tput cols) / 2))
c=$((col - 1))
est=$((c - 2))
color=0
tput setaf 2; tput bold

# Draw the tree
for ((i=1; i<20; i+=2)); do
    tput cup $lin $col
    for ((j=1; j<=i; j++)); do
        echo -n "*"
    done
    ((lin++))
    ((col--))
done

# Reset color and set trunk color
tput sgr0; tput setaf 3

# Draw the tree trunk
for ((i=1; i<=2; i++)); do
    tput cup $((lin++)) $c
    echo "mWm"
done

# Get next year for the greeting
new_year=$(date +'%Y')
((new_year++))

# Display the messages
tput setaf 1; tput bold
tput cup $lin $((c - 6)); echo "MERRY CHRISTMAS"
tput cup $((lin + 1)) $((c - 10)); echo "And lots of CODE in $new_year"
((c++))

# Initialize decoration variables
k=1
declare -a line column

# Lights and decorations loop
while true; do
    for ((i=1; i<=35; i++)); do
        # Turn off the previous light
        if ((k > 1)); then
            tput setaf 2; tput bold
            tput cup ${line[$((k-1))$i]} ${column[$((k-1))$i]}; echo "*"
            unset line[$((k-1))$i]; unset column[$((k-1))$i]  # Cleanup arrays
        fi

        # Generate new light position and color
        li=$((RANDOM % 9 + 3))
        start=$((c - li + 2))
        co=$((RANDOM % (li - 2) * 2 + 1 + start))
        
        # Set random color for the light
        tput setaf $color; tput bold
        tput cup $li $co
        echo "o"
        
        # Store light position in arrays
        line[$k$i]=$li
        column[$k$i]=$co
        color=$(((color + 1) % 8))  # Cycle through colors

        # Flashing text "CODE"
        sh=1
        for l in C O D E; do
            tput cup $((lin + 1)) $((c + sh))
            echo "$l"
            ((sh++))
            sleep 0.01
        done
    done

    # Toggle between light arrays
    k=$((k % 2 + 1))
done
