#!/usr/bin/env bash

#### Description: Configure iptables
#### Written by: Guillermo de Ignacio - gdeignacio on 12-2022


######################################
###    CONFIGURE IPTABLES          ###
######################################

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./app_configure_from_scratch.sh

Creates an app from scratch

              Following steps are up to you
              Execute app_settings.sh
                      app_setappname.sh --codapp=codapp --app=app
                      app_setenv.sh    

'
    exit
fi

echo ""
PROJECT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"
echo "Project path at $PROJECT_PATH"
echo ""
echo "[$(date +"%Y-%m-%d %T")] Setting builds and deploy conf files..."
echo ""

# Taking values from .env file

source $PROJECT_PATH/bin/lib_string_utils.sh 
source $PROJECT_PATH/bin/lib_env_utils.sh

lib_env_utils.loadenv ${PROJECT_PATH}
echo ""

echo "Configure iptables"

# Add routes for each host through an interface
declare -A ROUTES=(
    ["host1"]="192.0.20.2"
    ["host2"]="192.0.40.2"
)

for host in "${!ROUTES[@]}"; do
    ip="${ROUTES[$host]}"
    iptables -A FORWARD -s "$ip" -o enp0s3 -j ACCEPT
    iptables -A FORWARD -d "$ip" -i enp0s3 -m state --state ESTABLISHED,RELATED -j ACCEPT
done



echo ""
echo "End of automated settings"
