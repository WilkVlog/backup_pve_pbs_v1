#!/bin/bash

_VERSION="1.0.0"

#=============================================================================
#
# Script created by WilkVlog 
#
# YouTube: WilkVlog https://www.youtube.com/channel/UC4VcTVCCcsTUS7bc-CkiTKw
# GitHub: https://github.com/WilkVlog/backup_pve_v1 
#
# Set executable permissions: 
# chmod +x wol_send.sh
#
# Requirements:
# apt update && apt install ethtool etherwake
#
# Published: 2024
#
#=============================================================================

HELP="
Version $_VERSION (2024)

Usage:
 WOL_on.sh <OPTION> <MAC> <INTERFACE>

 Arguments:

  OPTION:
    -e - script will use etherwake (interface name required)
    -w - script will use wakeonlan

  MAC       - target MAC address
  INTERFACE - server interface to send packet

Example of use: 
  ./WOL_on.sh -e AA:BB:CC:DD:EE:FF ens1
  ./WOL_on.sh -w AA:BB:CC:DD:EE:FF
"

# Check if the required parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "$HELP"
else
    # Use etherwake
    if [ "$1" == "-e" ]; then
        if [ -n "$3" ]; then # Check if the required interface name is specified
            etherwake -i $3 $2
            SUCCESS=$?            
            if [ $SUCCESS -eq 0 ]; then
                echo "Sending magic packet to 255.255.255.255 with $2"
            fi
        else
            echo "Interface name required"
        fi
    # Use wakeonlan
    elif [ "$1" == "-w" ]; then
        wakeonlan $2
    else
        echo "$HELP"
    fi
fi
