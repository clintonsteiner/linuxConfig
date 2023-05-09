# /bin/bash

echo creating $backupName of ${PWD}/CURRENT_FILES

backupPath=/mnt/disk1/data/backups/linux_backups/cj_thinkpad
echo ${backupPath}/FULL/${backupName} > /tmp/backup_filename.log
tar -zcvf ${backupPath}/FULL/${backupName} ${backupPath}/CURRENT_FILES/

echo Deleting files $(ls -1t ${backupPath}/FULL/ | tail -n +3)
rm -f $(ls -1t ${backupPath}/FULL/ | tail -n +3)
