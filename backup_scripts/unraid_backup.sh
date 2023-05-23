# /bin/bash

echo ls -l root@rhino:/mnt/docker/appdataJKUrsync -av --delete --exclude='plex' root@rhino:/mnt/docker/appdata/ /home/cj/Desktop/unraidBackup/CURRENT_FILES/mnt/docker/appdata/ --dry-run
rsync -av --delete --exclude 'plex' root@rhino:/mnt/docker/appdata/ /home/cj/Desktop/unraidBackup/CURRENT_FILES/mnt/docker/appdata/
systemName=$(cat /etc/hostname)                                                                                                                                                                                                               
today=$(date +%F)
backupName=${USER}_${systemName}_${today}_backup.tar.gz

echo creating $backupName of ${PWD}/CURRENT_FILES

backupPath=/home/cj/Desktop/unraidBackup
echo ${backupPath}/FULL/${backupName} > /tmp/backup_filename.log
tar --use-compress-program="pigz -k " -cvf ${backupPath}/FULL/${backupName} ${backupPath}/CURRENT_FILES/

echo Deleting files $(ls -1t ${backupPath}/FULL/ | tail -n +3)
rm -f $(ls -1t ${backupPath}/FULL/ | tail -n +3)

