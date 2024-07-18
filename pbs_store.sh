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
# chmod +x pbs_store.sh
#
# Published: 2024
# 
#=============================================================================


HELP="
Version $_VERSION (2024)

The script checks whether the specified Proxmox Backup host responds (or not) to the ping, 
if so, it adds (or removes if not respond) the specified Proxmox Backup storage.

Usage:
 pbs_store.sh <FUNCTION> <HOST_IP> <STORAGE_ID> <PBS_DATASTORE> <PBS_FINGERPRINT> <PBS_USERNAME> <PBS_PASSWORD>

 Arguments:

  FUNCTIONS:
    -add - script will add storage to Proxmox (all arguments are required)
    -rm  - script will remove storage from Proxmox if exists (only STORAGE_ID is required)

  HOST_IP         - Proxmox Backup Server host IP address 
  STORAGE_ID      - Storage name for mounted Proxmox Backup Server storage in Proxmox VE
  PBS_DATASTORE   - Storage name with backups in Proxmox Backup Server (datastore name from Proxmox Backup Server)
  PBS_FINGERPRINT - Proxmox Backup Server Fingerprint
  PBS_USERNAME    - Proxmox Backup Server user login
  PBS_PASSWORD    - Proxmox Backup Server user password 


 Example of use: 

  ./pbs_store.sh add 10.0.0.50 pbs_backup01 bakdisk1 01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32 backupuser@pbs secretPassword

  ./pbs_store.sh rm pbs_backup01

"

FUNCTION=$1
HOST_IP=$2
STORAGE_ID=$3
PBS_DATASTORE=$4
PBS_FINGERPRINT=$5
PBS_USERNAME=$6
PBS_PASSWORD=$7


# Function rm
# Remove given STORAGE_ID from Proxmox storages
if [ "$FUNCTION" = "-rm" ]; then
    echo "Unmounting storage $2"
    /usr/sbin/pvesm remove $2

# Function add
# Add given Proxmox Backup Server storage to Proxmox storages if specified host responds to the ping.
# Function also removes given Proxmox Backup Server storage from Proxmox storages if specified host does not respond to the ping.   
elif [ "$FUNCTION" = "-add" ]; then
    
    # Check if the required parameters are provided
    if [[ -z "$FUNCTION" || -z "$HOST_IP" || -z "$STORAGE_ID" || -z "$PBS_DATASTORE" || -z "$PBS_FINGERPRINT" || -z "$PBS_USERNAME" || -z "$PBS_PASSWORD" ]]; then
        echo "------------------------------------------------------------------------------"
        echo 
        echo "Error: Missing parameters"
        echo
        echo "------------------------------------------------------------------------------"
        echo "$HELP"    
    else
        ping -c1 $HOST_IP 1>/dev/null 2>/dev/null
        SUCCESS=$?

        if [ $SUCCESS -eq 0 ]; then
            echo "Host $HOST_IP is responding"

            # check if STORAGE_ID doesn't exists in storage.cfg file. If it doesn't exists then add STORAGE_ID
            if ! grep -q $STORAGE_ID "/etc/pve/storage.cfg"; then 
                echo "Mounting storage $STORAGE_ID"
                /usr/sbin/pvesm add pbs $STORAGE_ID --datastore $PBS_DATASTORE --server $HOST_IP --fingerprint $PBS_FINGERPRINT --username $PBS_USERNAME --password $PBS_PASSWORD
            else
                echo "$STORAGE_ID already exists"
            fi
        else # Remove given STORAGE_ID if host does not respond to the ping
            echo "Host $HOST_IP is not responding"
            /usr/sbin/pvesm remove $STORAGE_ID
        fi
    fi

else # Print information if the function is not known
    echo "------------------------------------------------------------------------------"
    echo
    echo "Error: Unknown function. Available functions: -add, -rm"
    echo 
    echo "------------------------------------------------------------------------------"
    echo "$HELP"
fi
