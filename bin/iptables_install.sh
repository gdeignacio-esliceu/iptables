#!/usr/bin/env bash

#### Description: Installs iptables
#### Written by: Guillermo de Ignacio - gdeignacio on 04-2024

###################################
###   IPTABLES INSTALL UTILS    ###
###################################

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./docker_install.sh

Installs docker packages

'
    exit
fi


echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Installing iptables..."
echo ""

# Taking values from .env file

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}
echo ""
lib_env_utils.check_os
echo ""

isLinux=$(lib_env_utils.check_os)

if [[ isLinux -eq 1 ]]; then

    sudo apt-get update
    sudo apt-get upgrade

    sudo apt-get install iptables
    sudo service iptables start
    sudo service iptables enable

else
    echo ""
    echo "iptables should be installed manually"
    echo ""
fi

