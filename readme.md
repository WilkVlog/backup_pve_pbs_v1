## **[ENGLISH]**  

**pbs_storage_arg.sh** - script with argument parser (the order of arguments is not important)  
**pbs_storage.sh** - script where arguments order is important  
  
  
## pbs_store_arg.sh  
  
The script with "add" checks whether the specified Proxmox Backup Server host responds (or not) to the ping, 
if so, it adds (or removes if not respond) the specified Proxmox Backup storage.  
  
Usage:  
 pbs_store.sh <ARGUMENTS>  
  
 **Arguments:**  
    -h | --help             - help  
    -a | --add              - script will add storage to Proxmox (all arguments are required)  
    -r | --remove           - script will remove storage from Proxmox if exists (only STORAGE_ID is required)  
    -sn | --storage-name      - Storage name for mounted Proxmox Backup Server storage in Proxmox VE  
    -pi | --pbs-ip          - Proxmox Backup Server host IP address  
    -pd | --pbs-datastore   - Storage name with backups in Proxmox Backup Server (datastore name from Proxmox Backup Server)  
    -pf | --pbs-fingerprint - Proxmox Backup Server Fingerprint  
    -pu | --pbs-username    - Proxmox Backup Server user login  
    -pp | --pbs-password    - Proxmox Backup Server user password  
  
  
 **Example of use:**  
  
  ./pbs_store.sh -a -pi 10.0.0.50 -sn pbs_backup01 -ps bakdisk1 -pf 01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32 -pu backupuser@pbs -pp secretPassword  
  
  ./pbs_store.sh -r pbs_backup01  
    
## pbs_store.sh

Usage:
 pbs_store.sh <FUNCTION> <HOST_IP> <STORAGE_ID> <PBS_DATASTORE> <PBS_FINGERPRINT> <PBS_USERNAME> <PBS_PASSWORD>

    
 **Arguments:**

  -add - script will add storage to Proxmox (all arguments are required)  
  -rm  - script will remove storage from Proxmox if exists (only STORAGE_ID is required)  

  HOST_IP         - Proxmox Backup Server host IP address   
  STORAGE_ID      - Storage name for mounted Proxmox Backup Server storage  
  PBS_DATASTORE   - Storage name with backups in Proxmox Backup Server (datastore name from Proxmox Backup Server)  
  PBS_FINGERPRINT - Proxmox Backup Server Fingerprint (available in PBS dashboard)  
  PBS_USERNAME    - Proxmox Backup Server user login  
  PBS_PASSWORD    - Proxmox Backup Server user password  


 **Example of use:**   

  ./pbs_store.sh -add 10.0.0.13 pbs_backup01 bakdisk1 01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32 backupuser@pbs secretPassword  
  
  ./pbs_store.sh -rm pbs_backup01 

## wol_send.sh  
  
Script for WOL (Wake On LAN)  
  
**Usage:**  
 WOL_on.sh <OPTION> <MAC> <INTERFACE>  
  
 **Arguments:** 
   
    -e - script will use etherwake (MAC and interface name is required)  
    -w - script will use wakeonlan (only MAC is required)  
  
  MAC       - target MAC address  
  INTERFACE - server interface to send packet 
  
**Example of use:**   
  ./WOL_on.sh -e AA:BB:CC:DD:EE:FF ens1  
  ./WOL_on.sh -w AA:BB:CC:DD:EE:FF  
  
---  

## **[POLSKI]**  
  
## pbs_store.sh           
  
Skrypt z funkcją -add sprawdza czy podany adres IP hosta z Proxmox Backup Server odpowiada na ping czy nie.  
Jeśli odpowiada to dodaje/montuje storage w Proxmox VE lub usuwa dodany już zasób jeśli Proxmox Backup Server nie odpowiada na ping.  
  
**Usage:**  
 pbs_store.sh <FUNKCJA> <ADRES_IP> <STORAGE_ID> <PBS_DATASTORE> <PBS_FINGERPRINT> <PBS_UZYTKOWNIK> <PBS_HASLO>  

      
 **Argumenty:**   
 
  -add - skrypt doda storage do Proxmoxa (wymagane jest podanie wszystkich argumentów)  
  -rm  - skrypt usuwa storage z Proxmoxa (należy podać STORAGE_ID do usunięcia)   
  
  HOST_IP         - Adres IP Proxmox Backup Server  
  STORAGE_ID      - Nazwa storage/magazynu pod jaką w Proxmox VE zostanie zamontowany storage Proxmox Backup Server  
  PBS_DATASTORE   - Nazwa storage/magazynu backupów w Proxmox Backup Server (nazwa datastore z Proxmox Backup Server)  
  PBS_FINGERPRINT - Proxmox Backup Server Fingerprint (tzw. odcisk palca dostępny w panelu PBS)  
  PBS_USERNAME    - Proxmox Backup Server użytkownik  
  PBS_PASSWORD    - Proxmox Backup Server hasło użytkownika  
  
  
 **Example of use:**   
  
  ./pbs_store.sh -add 10.0.0.13 pbs_backup01 bakdisk1 01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32 backupuser@pbs secretPassword  
  
  ./pbs_store.sh -rm pbs_backup01  

## wol_send.sh  
  
Skrypt do funkcji WOL (Waken On LAN)  
  
**Użycie:*  
  WOL_on.sh <OPCJE> <MAC> <INTERFEJS_SIECIOWY>  
  
  **Argumenty:** 
    
    -e - skrpyt wykorzystuje komendę etherwake, która wymaga podania MAC adresu i nazwy interfejsu do wysłania pakietu  
    -w - skrypt wykorzystuje komendę wakeonlan, która wymaga podania MAC adresu  

  MAC - docelowy MAC adres  
  INTERFACE - nazwa karty sieciowej przez którą ma zostać wysłany pakiet
   
**Przykład:**     
  ./WOL_on.sh -e AA:BB:CC:DD:EE:FF ens1  
  ./WOL_on.sh -w AA:BB:CC:DD:EE:FF  

      
