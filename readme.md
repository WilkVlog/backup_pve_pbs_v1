The script with function -add checks whether the specified Proxmox Backup Server host responds (or not) to the ping, 
if so, it adds (or removes if not respond) the specified Proxmox Backup storage.

Usage:
 pbs_store.sh <FUNCTION> <HOST_IP> <STORAGE_ID> <PBS_DATASTORE> <PBS_FINGERPRINT> <PBS_USERNAME> <PBS_PASSWORD>

    
 **Arguments:**

 **FUNCTIONS:**  
    -add - script will add storage to Proxmox (all arguments are required)  
    -rm  - script will remove storage from Proxmox if exists (only STORAGE_ID is required)  

  HOST_IP         - Proxmox Backup Server host IP address   
  STORAGE_ID      - Storage name for mounted Proxmox Backup Server storage  
  PBS_DATASTORE   - Storage name with backups in Proxmox Backup Server (datastore name from Proxmox Backup Server)  
  PBS_FINGERPRINT - Proxmox Backup Server Fingerprint (available in PBS dashboard)  
  PBS_USERNAME    - Proxmox Backup Server user login  
  PBS_PASSWORD    - Proxmox Backup Server user password  


 **Example of use:**   

  ./pbs_store.sh add 10.0.0.13 pbs_backup01 bakdisk1 01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32 backupuser@pbs secretPassword  
  
  ./pbs_store.sh rm pbs_backup01  

 ---

Skrypt z funkcją -add sprawdza czy podany adres IP hosta z Proxmox Backup Server odpowiada na ping czy nie.  
Jeśli odpowiada to dodaje/montuje storage w Proxmox VE lub usuwa dodany już zasób jeśli Proxmox Backup Server nie odpowiada na ping.  
  
**Usage:**  
 pbs_store.sh <FUNKCJA> <ADRES_IP> <STORAGE_ID> <PBS_DATASTORE> <PBS_FINGERPRINT> <PBS_UZYTKOWNIK> <PBS_HASLO>  

      
 **Argumenty:**   
  
  **FUNKCJE:**  
    -add - skrypt doda storage do Proxmoxa (wymagane jest podanie wszystkich argumentów)  
    -rm  - skrypt usuwa storage z Proxmoxa (należy podać STORAGE_ID do usunięcia)   
  
  HOST_IP         - Adres IP Proxmox Backup Server  
  STORAGE_ID      - Nazwa storage/magazynu pod jaką w Proxmox VE zostanie zamontowany storage Proxmox Backup Server  
  PBS_DATASTORE   - Nazwa storage/magazynu backupów w Proxmox Backup Server (nazwa datastore z Proxmox Backup Server)  
  PBS_FINGERPRINT - Proxmox Backup Server Fingerprint (tzw. odcisk palca dostępny w panelu PBS)  
  PBS_USERNAME    - Proxmox Backup Server użytkownik  
  PBS_PASSWORD    - Proxmox Backup Server hasło użytkownika  
  
  
 **Example of use:**   
  
  ./pbs_store.sh add 10.0.0.13 pbs_backup01 bakdisk1 01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:27:28:29:30:31:32 backupuser@pbs secretPassword  
  
  ./pbs_store.sh rm pbs_backup01  
    
