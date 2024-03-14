#!/bin/bash
#############################
# SHG Backup script v1.0
# Back up HLDS/SRCDS/S2 servers with ease
# Use with steamcmd servers or servers where you have access to the base directory
#
# Dependencies: zstd, tar
# Author: sh0tx
#############################

# Config options:
CFG_BACKUPTO="srcds_backup"     # Directory to back up files
CFG_BACKUPFROM=(                # Which directories to back up
    "shg_surf"
)

# util vars
clGreen="\033[1;32m"
clRed="\033[1;31m"
clWhite="\033[1;37m"
clReset="\033[0m"

sPfx="${clRed}[SHG]${clWhite}"

# Misc/util functions
function fnExit {
    printf "\n${V_PREFIX}Exiting script...${C_RS}\n\n"
    exit
}

# Backup start function
function fnStartBackup {
    # Make directories for files before proceeding
    mkdir -p ${CFG_BACKUPTO}

    # Check for dependencies and install if not available
    which zstd >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        printf "${sPfx} Dependency found: zstd\n"
    else
        printf "${sPfx} Dependency not found: zstd, installing..."
        sudo apt -y install zstd
    fi

    # Pack directories
    for dir in "${CFG_BACKUPFROM[@]}"
    do
        printf "${sPfx} Backing up directory to .zst archive: ${clGreen}${dir}${clReset}\n"
        tar --use-compress-program zstd -cf ${dir}.zst ./${dir}/
        mv -v ${dir}.zst ./${CFG_BACKUPTO}/${dir}.zst
        # sudo chown $(whoami):$(whoami) ${backupto_dir}/${dir}.zst
    done
    
    # Last task: pack the whole backup directory to one archive and
    # remove the original dir
    #printf "${sPfx} Packing backup directory...${C_RS}\n"
    #tar --use-compress-program zstd -cvf ${backupto_dir}.zst ./${backupto_dir}/
    #rm -r ./${backupto_dir}/
    printf "${sPfx} ${clGreen}Backup is now ready to be downloaded.${clReset}"
}

# Prompt user to check for home dir
# echo -e "${V_PREFIX}Please make sure you are running this script in your home directory. (default: /home/opc)${C_RS}"
while true; do
    printf "${sPfx} Are you sure you want to proceed? [Y/n]${clReset}"
    read -p " " proceedyn
    case $proceedyn in
        [Yy]* )
            fnStartBackup
            fnExit
        ;;
        [Nn]* )
            fnExit
        ;;
    esac
done
