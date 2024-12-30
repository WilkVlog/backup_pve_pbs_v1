#!/bin/bash

_VERSION="1.1.0"

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
 pbs_store.sh <ARGUMENTS>

 Arguments:
    -h | --help             - help
    -a | --add              - script will add storage to Proxmox (all arguments are required)
    -r | --remove           - script will remove storage from Proxmox if exists (only STORAGE_ID is required)
    -sn | --storage-name      - Storage name for mounted Proxmox Backup Server storage in Proxmox VE
    -pi | --pbs-ip          - Proxmox Backup Server host IP address
    -pd | --pbs-datastore   - Storage name with backups in Proxmox Backup Server (datastore name from Proxmox Backup Server)
    -pf | --pbs-fingerprint - Proxmox Backup Server Fingerprint
    -pu | --pbs-username    - Proxmox Backup Server user login
    -pp | --pbs-password    - Proxmox Backup Server user password


 Example of use: 

  ./pbs_store.sh -a -pi 10.0.0.50 -sn pbs_backup01 -ps bakdisk1 -pf 01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32 -pu backupuser@pbs -pp secretPassword

  ./pbs_store.sh -r pbs_backup01

"
SWHELP=false
ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
        echo "$HELP"   
        SWHELP=true 
        shift
        ;;
    -a|--add)
        FUNCTION="add"
        shift 
        ;;
    -r|--remove)
        FUNCTION="rm"
        shift 
        ;;
    -sn|--storage-name)
        STORAGE_ID="$2"
        shift 2
        ;;
    -pi|--pbs-ip)
        PBS_IP="$2"
        shift 2
        ;;
    -pd|--pbs-datastore)
        PBS_DATASTORE="$2"
        shift 2
        ;;
    -pf|--pbs-fingerprint)
        PBS_FINGERPRINT="$2"
        shift 2
        ;;
    -pu|--pbs-user)
        PBS_USERNAME="$2"
        shift 2
        ;;
    -pp|--pbs-password)
        PBS_PASSWORD="$2"
        shift 2
        ;;
    -*|--*)
        echo
        echo "Unknown option $1. See $0 -h or $0 --help"
        echo
        exit 1
        ;;
    *)
        ARGS+=("$1") # save positional arg
        shift # past argument
        ;;
  esac
done


if ! $SWHELP; then # if help is not printed

    # Function rm
    # Remove given STORAGE_ID from Proxmox storages
    if [ "$FUNCTION" = "rm" ]; then
        echo "Unmounting storage $STORAGE_ID"
        /usr/sbin/pvesm remove $STORAGE_ID

    # Function add
    # Add given Proxmox Backup Server storage to Proxmox storages if specified host responds to the ping.
    # Function also removes given Proxmox Backup Server storage from Proxmox storages if specified host does not respond to the ping.   
    elif [[ "$FUNCTION" = "add" ]]; then
        
        # Check if the required parameters are provided
        if [[ -z "$FUNCTION" || -z "$PBS_IP" || -z "$STORAGE_ID" || -z "$PBS_DATASTORE" || -z "$PBS_FINGERPRINT" || -z "$PBS_USERNAME" || -z "$PBS_PASSWORD" ]]; then
            echo "------------------------------------------------------------------------------"
            echo 
            echo "Error: Missing parameters"
            echo
            echo "See help $0 -h or $0 --help"
            echo
            echo "------------------------------------------------------------------------------"
        else
            ping -c1 $PBS_IP 1>/dev/null 2>/dev/null
            SUCCESS=$?

            if [ $SUCCESS -eq 0 ]; then
                echo "Host $PBS_IP is responding"

                # check if STORAGE_ID doesn't exists in storage.cfg file. If it doesn't exists then add STORAGE_ID
                if ! grep -q $STORAGE_ID "/etc/pve/storage.cfg"; then 
                    echo "Mounting storage $STORAGE_ID"
                    /usr/sbin/pvesm add pbs $STORAGE_ID --datastore $PBS_DATASTORE --server $PBS_IP --fingerprint $PBS_FINGERPRINT --username $PBS_USERNAME --password $PBS_PASSWORD
                else
                    echo "$STORAGE_ID already exists"
                fi
            else # Remove given STORAGE_ID if host does not respond to the ping
                echo "Host $PBS_IP is not responding"
                /usr/sbin/pvesm remove $STORAGE_ID
            fi
        fi

    else 
        echo "------------------------------------------------------------------------------"
        echo
        echo "Error: missing arguments "
        echo
        echo "See help $0 -h or $0 --help"
        echo 
        echo "------------------------------------------------------------------------------"
    fi
fi