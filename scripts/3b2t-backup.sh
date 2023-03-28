#!/bin/bash

# SETTINGS
backupto_dir="srv_backup" # Directory where to back up any files
backupfrom_dirs=( # Directories to be backed up
    "3b2t.online"
    "velocity-proxy"
)
backupfrom_services=( # systemd service files to back up
    "3b2t.service"
    "velocity.service"
)
sqldb="anarchy" # Name of the database to back up

# Colors
C_RED="\033[1;31m"
C_GREEN="\033[1;32m"
C_WHITE="\033[1;37m"
C_RS="\033[0m"

# other variables
V_PREFIX="${C_RED}[3b2t.online]${C_WHITE} "

# Misc/util functions
function m_exit {
    printf "\n${V_PREFIX}Exiting script...${C_RS}\n\n"
    exit
}

# Backup start function
function start_backup {
    # Make directories for files before proceeding
    mkdir -p $backupto_dir
    mkdir -p $backupto_dir/services

    # Install dependencies
    sudo dnf -y install zstd

    # Back up SQL database
    printf "\n${V_PREFIX}Backing up MariaDB database: ${C_GREEN}${sqldb}.sql${C_RS}\n"
    sudo mysqldump -u root --opt $sqldb > ${backupto_dir}/${sqldb}.sql

    # Pack directories
    for dir in "${backupfrom_dirs[@]}"
    do
        printf "${V_PREFIX}Backing up directory to .zst archive: ${C_GREEN}$dir${C_RS}\n"
        sudo tar --use-compress-program zstd -cf ${dir}.zst ${dir}/
        sudo mv -v ${dir}.zst ${backupto_dir}/${dir}.zst
        sudo chown $(whoami):$(whoami) ${backupto_dir}/${dir}.zst
    done
    
    # Back up systemd service files
    for svc in "${backupfrom_services[@]}"
    do
        printf "${V_PREFIX}Copying systemd service file: ${C_GREEN}${svc}${C_RS}\n"
        sudo cp -v /etc/systemd/system/${svc} ${backupto_dir}/services/${svc}
        sudo chown $(whoami):$(whoami) ${backupto_dir}/services/${svc}
    done
    
    # Last task: pack the whole backup directory to one archive and
    # remove the original dir
    printf "${V_PREFIX}Packing backup directory...${C_RS}\n"
    tar --use-compress-program zstd -cvf ${backupto_dir}.zst ${backupto_dir}/
    rm -r ${backupto_dir}/
    printf "${V_PREFIX}${C_GREEN}Backup is now ready to be downloaded."
}

# Prompt user to check for home dir
echo -e "${V_PREFIX}Please make sure you are running this script in your home directory. (default: /home/opc)${C_RS}"
while true; do
    printf "${V_PREFIX}Proceed? [Y/n]${C_RS}"
    read -p " " proceedyn
    case $proceedyn in
        [Yy]* )
            start_backup
            m_exit
        ;;
        [Nn]* )
            m_exit
        ;;
    esac
done
