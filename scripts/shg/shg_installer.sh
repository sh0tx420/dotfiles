#!/bin/bash
###################
#
# SHG Server installer (HLDS/SRCDS/S2) v1.4
# 
# Dependencies:
#   steamcmd | wget | tar | zip | unzip
#   (Ubuntu 20.04.6 LTS): lib32gcc1 | lib32stdc++6 | libsdl2-2.0-0:i386 | libcurl4-gnutls-dev:i386
#
# Notes:
# CFG_INSTALL_MODS will install the following server mods for their according server:
#
#   - HLDS (cstrike):       ReHLDS
#                           ReGameDLL
#                           Metamod-r
#                           AMX Mod X
#
#   - Sven Co-op DS:        Metamod-p (patch)
#                           AMX Mod X
#
#   - Any SRCDS:            Metamod:Source 1.12
#                           Sourcemod 1.12
#
#   - Counter-Strike 2 DS:  Metamod:Source 2.0
#                           Source2Mod
#
#   - Misc:                 rafradek's SRCDS Optimizer (Normal/No-MVM)
#                           Counter-Strike package for AMX Mod X
#
# Changelog:
#   1.0-1.5:
#     - Updated documentation
#     - Added supporting for installing server mods (not just AMXX now)
#
# Future plans:
#   - Auto-detect linux distro and package manager, then install dependencies for that distro
#
# Author: sh0tx
#
###################

# Config options:
CFG_INSTALL_MODS=1         # Install server mods automatically? | 0 - false 1 - true


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

function fnMain {
    printf "${sPfx} Server installer v${sVersion}\n\n"
    
    # Check if dependencies exist
    fnCheckDependencies
    
    # Now we can proceed to start installing
    while true; do
        printf "${sPfx} Please input a valid Steam AppID to install: "

        read appid

        if [[ ! $appid =~ ^[0-9]+$ ]]; then
            printf "${sPfx} Invalid input.\n"
            continue
        else
            fnInstallServer $appid
            break
        fi
    done
}

function fnCheckDependencies {
    # TODO: change package manager and dependency list based on distribution (make a function to determine it)
    ogIFS=$IFS

    deps=("steamcmd" "wget" "tar" "zip" "unzip" "lib32gcc1" "lib32stdc++6" "libsdl2-2.0-0:i386" "libcurl4-gnutls-dev:i386")
    missing_deps=()
    
    # loop through dependencies and add to missing_deps if package not found
    for dep in "${deps[@]}"; do
        if ! dpkg -s "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    IFS=","
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        printf "${sPfx} Dependencies not found: ${missing_deps[@]}, installing...\n${clReset}"
        sudo apt -y install "${missing_deps[@]}"
    else
        printf "${sPfx} Dependencies found: ${missing_deps[@]}\n"
    fi
    
    IFS=$ogIFS
}

function fnInstallModsToDir {
    # args $1   $2
    # desc mod  directory
    
    # $1 options:
    #   HLDS Patches:               rehlds | regamedll
    #   Server plugin support:      metamod_r | metamod_p | mmsource | mmsource2
    #   Server plugin frameworks:   amxx | sourcemod | source2mod
    #   Misc:                       srcds_opt_tf | srcds_opt_tf_nomvm | amxx_cs
    
    sUrlReHLDS="https://github.com/dreamstalker/rehlds/releases/download/3.13.0.788/rehlds-bin-3.13.0.788.zip"
    sUrlReGameDLL="https://github.com/s1lentq/ReGameDLL_CS/releases/download/5.26.0.668/regamedll-bin-5.26.0.668.zip"

    # TODO: update metamod-p url to patched version (i was too lazy to do this)
    sUrlMetamodR="https://github.com/theAsmodai/metamod-r/releases/download/1.3.0.138/metamod-bin-1.3.0.138.zip"
    sUrlMetamodP="https://github.com/Bots-United/metamod-p/releases/download/v1.21p38/metamod_i686_linux_win32-1.21p38.tar.xz"
    sUrlMMSource="https://mms.alliedmods.net/mmsdrop/1.12/mmsource-1.12.0-git1192-linux.tar.gz"
    sUrlMMSource2="https://mms.alliedmods.net/mmsdrop/2.0/mmsource-2.0.0-git1284-linux.tar.gz"

    # NOTE: as of 19.3.24. Source2Mod doesn't exist (at least a public build) yet. update sUrlSource2Mod when it does.
    sUrlAMXX="https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-base-linux.tar.gz"
    sUrlSourcemod="https://sm.alliedmods.net/smdrop/1.12/sourcemod-1.12.0-git7113-linux.tar.gz"
    sUrlSource2Mod=""
    
    sUrlAMXX_CS="https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-cstrike-linux.tar.gz"
    
    mkdir -p tmp
    
    case $1 in
        "rehlds")
            ;;
        "regamedll")
            ;;
        "metamod_r")
            ;;
        "metamod_p")
            ;;
        "mmsource")
            printf "${sPfx} Installing Metamod:Source v1.12 to: $2\n${clReset}"

            wget -qO ./tmp/mmsource.tar.gz $sUrlMMSource
            tar -xf ./tmp/mmsource.tar.gz -C $2
            ;;
        "mmsource2")
            ;;
        "amxx")
            ;;
        "sourcemod")
            printf "${sPfx} Installing Sourcemod v1.12 to: $2\n${clReset}"

            wget -qO ./tmp/sourcemod.tar.gz $sUrlSourcemod
            tar -xf ./tmp/sourcemod.tar.gz -C $2
            
            fnInstallConfigs "sourcemod" $2
            ;;
        "source2mod")
            ;;
        "srcds_opt_tf")
            ;;
        "srcds_opt_tf_nomvm")
            ;;
        "amxx_cs")
            ;;
    esac
    
    rm -r ./tmp/
}

function fnInstallConfigs {
    # args  $1      $2
    #       mod     directory
    
    # $1 options: sourcemod
    sRepoOwner="sh0tx420"
    sRepoName="sm-plugindev"
    sConfigsUrl="https://github.com/${sRepoOwner}/${sRepoName}/archive/refs/heads/main.zip"
    
    case $1 in
        "sourcemod")
            printf "${sPfx} Installing SHG configs for Sourcemod\n"
            
            wget -qO ./tmp/configs.zip $sConfigsUrl
            unzip -q ./tmp/configs.zip
            mv "./${sRepoName}-main/" "./tmp/${sRepoName}-main"

            #rm -r "./tmp/${sRepoName}-main/configs/cvars/*.md"
            #cp -r "./tmp/${sRepoName}-main/configs/cvars/" "$2/cfg/sourcemod/"
            find "./tmp/${sRepoName}-main/configs/cvars/" -type f -name "*.cfg" -exec cp {} "$2/cfg/sourcemod/" \;
            # rm -r "./tmp/${sRepoName}-main/configs/cvars"
            cp -r "./tmp/${sRepoName}-main/configs/" "$2/addons/sourcemod/" # this has a bug where it creates a new configs dir in the configs dir (wtf?)
            #find "./tmp/${sRepoName}-main/configs/cvars/" -type f -exec cp {} "$2/addons/sourcemod/configs/" \;
            cp -r "./tmp/${sRepoName}-main/data/" "$2/addons/sourcemod/"
            cp -r "./tmp/${sRepoName}-main/gamedata/" "$2/addons/sourcemod/"
            ;;
    esac
}

function fnInstallServer {
    printf "${sPfx} Please type in your install directory (relative to this one): "
    
    read installdir
    
    # Install server from steamcmd to directory
    printf "\n${sPfx} Installing server...\n"
    printf "${sPfx} AppID: $1 | Dir: ./${installdir}\n${clReset}"

    steamcmd +force_install_dir "$(pwd)/${installdir}" +login anonymous +app_update $1 validate +quit
    
    if [ "$CFG_INSTALL_MODS" -eq 1 ]; then
        case $1 in
            276060)
                fnInstallModsToDir "metamod_p" "./${installdir}/svencoop"
                fnInstallModsToDir "amxx" "./${installdir}/svencoop"
                ;;
            90)
                # rehlds
                fnInstallModsToDir "rehlds" "./${installdir}/cstrike"
                fnInstallModsToDir "regamedll" "./${installdir}/cstrike"
                fnInstallModsToDir "metamod_r" "./${installdir}/cstrike"
                fnInstallModsToDir "amxx" "./${installdir}/cstrike"
                ;;
            232250)
                fnInstallModsToDir "mmsource" "./${installdir}/tf"
                fnInstallModsToDir "sourcemod" "./${installdir}/tf"
                # fnInstallModsToDir "srcds_opt_tf_nomvm" "./${installdir}/tf"
                ;;
            222840)
                fnInstallModsToDir "mmsource" "./${installdir}/l4d"
                fnInstallModsToDir "sourcemod" "./${installdir}/l4d"
                ;;
            222860)
                fnInstallModsToDir "mmsource" "./${installdir}/l4d2"
                fnInstallModsToDir "sourcemod" "./${installdir}/l4d2"
                ;;
            232330)
                fnInstallModsToDir "mmsource" "./${installdir}/cstrike"
                fnInstallModsToDir "sourcemod" "./${installdir}/cstrike"
                ;;
            232290)
                fnInstallModsToDir "mmsource" "./${installdir}/dods"
                fnInstallModsToDir "sourcemod" "./${installdir}/dods"
                ;;
        esac
    fi
    
    fnExit
}

fnMain
