#!/bin/bash
###################
# SHG Server installer (HLDS/SRCDS/S2) v1.0
# 
# Dependencies:
#   steamcmd | wget
#   (Ubuntu 20.04.6 LTS): lib32gcc1 | lib32stdc++6 | libsdl2-2.0-0:i386 | libcurl4-gnutls-dev:i386
#
# Author: sh0tx
###################

# Config options:
CFG_INSTALL_METAMOD="1"     # Install Metamod-r/Metamod-p (HLDS) or Metamod:Source (SRCDS, S2)? | 0 - false, 1 - true
CFG_INSTALL_SM_AMXX="1"     # Install AMX Mod X (HLDS) or Sourcemod (SRCDS)? | 0 - false, 1 - true

# Don't modify below unless you know what you're doing

clGreen="\033[1;32m"
clRed="\033[1;31m"
clWhite="\033[1;37m"
clReset="\033[0m"

sPfx="${clRed}[SHG]${clWhite}"
sVersion="1.0"

function fnExit {
    printf "\n${sPfx} Exiting...${clReset}\n"
}

# if [[ -n "${kvIdsHlds[$appid]}" ]] || [[ -n "${kvIdsSrcds[$appid]}" ]]; then

function fnMain {
    declare -A kvIdsHlds
    declare -A kvIdsSrcds

    kvIdsHlds["90"]="Half-Life"
    kvIdsHlds["276060"]="Sven Co-op"

    kvIdsSrcds["232330"]="Counter-Strike: Source"
    kvIdsSrcds["232250"]="Team Fortress 2"
    kvIdsSrcds["222860"]="Left 4 Dead 2"
    kvIdsSrcds["222840"]="Left 4 Dead"
    kvIdsSrcds["232290"]="Day of Defeat: Source"

    # access key's value with kvIdsX["id"]

    while true; do
        printf "${sPfx} Server installer v${sVersion}\n\n"
        
        # Check if dependencies exist
        fnCheckDependencies
        
        # Now we can proceed to start installing
        while true; do
            printf "${sPfx} Please input a valid Steam AppID to install.\n"
            
            read appid
            
            if [[ ! $appid =~ ^[0-9]+$ ]]; then
                printf "${sPfx} Invalid input.\n"
            fi
            
            if [[ -n "${kvIdsHlds[$appid]}" ]] || [[ -n "${kvIdsSrcds[$appid]}" ]]; then
                printf "${sPfx} AppID unknown or not supported.\n"
            else
                fnInstallServer $appid
            fi
        done
    done
}

function fnCheckDependencies {
    # TODO: change package manager and dependency list based on distribution (make a function to determine it)
    deps=("steamcmd", "wget", "lib32gcc1", "lib32stdc++6", "libsdl2-2.0-0:i386", "libcurl4-gnutls-dev:i386")
    missing_deps=()
    
    # loop through dependencies and add to missing_deps if package not found
    for dep in "${deps[@]}"; do
        if ! dpkg -s "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        printf "${sPfx} Dependencies not found: ${missing_deps[*]}, installing...\n${clReset}"
        for idep in $missing_deps; do
            sudo apt -y install $idep
        done
    else
        printf "${sPfx} Dependencies found: ${missing_deps[*]}\n"
    fi
}

function fnInstallServer {
    printf "${sPfx} Please type in your install directory (relative to this one): "
    
    read installdir
    
    # Install server from steamcmd to directory
    printf "\n${sPfx} Installing server...\n"
    printf "${sPfx} Game: %s" "$(if [[ -n "${kvIdsHlds[$1]}" ]]; then echo '${kvIdsSrcds[$1]}'; else echo '${kvIdsHlds[$1]}'; fi ]])"
    printf " | AppID: $1 | Dir: ./${installdir}\n${clReset}"

    steamcmd +login anonymous +force_install_dir "$(pwd)/${installdir}" +app_update $1 validate +quit
    
    # Determine if server is HLDS or SRCDS (or SOURCE2) and install MM/SM/AMXX accordingly
    # (oh god)
}

fnMain
