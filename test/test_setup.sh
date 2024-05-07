#!/usr/bin/env bash


#### Description: Test for setup
#### Written by: Guillermo de Ignacio - gdeignacio on 04-2021

###################################
###   Test environment values   ###
###################################

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./test_setup.sh

Test string conversions

'
    exit
fi


PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] testing setup..."
echo ""

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}

lib_env_utils.check_os

isLinux=$(lib_env_utils.check_os)
