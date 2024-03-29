#!/bin/bash
#####################
# SRCDS startup script 1.0
# Bash script for starting up a server and support for auto-restart in case of crash or just scheduled restart.
# Best used with steamcmd servers
# NOTE: Place this script in the same directory as srcds_run, otherwise you're retarted :3
#
# Dependencies: N/A
# Author: sh0tx
#####################

# Config options:
CFG_SERVER_GAME="tf"
CFG_SERVER_NAME="Team Fortress 2"  # just a simple identifier
CFG_START_MAP="ctf_2fort"
CFG_GSLT_TOKEN="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

# Don't modify below unless you know what you're doing

# util vars
clGreen="\033[1;32m"
clRed="\033[1;31m"
clWhite="\033[1;37m"
clReset="\033[0m"

sPfx="${clRed}[SHG]${clWhite}"

while true; do
    printf "${sPfx} Starting up gameserver: ${CFG_SERVER_NAME} | Game: ${CFG_SERVER_GAME}\n"
    printf "${clReset}"
    ./srcds_run -console -game $CFG_SERVER_GAME +ip 0.0.0.0 +map $CFG_START_MAP +maxplayers 32 +sv_setsteamaccount "$CFG_GSLT_TOKEN"
    
    # After this point, the server has exited
    printf "\n${sPfx} WARNING: Gameserver '${CFG_SERVER_NAME}' closed or crashed, restarting server in 5 seconds...\n"
    sleep 1
done
