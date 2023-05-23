# /bin/bash
systemName=$(cat /etc/hostname)
today=$(date +%F)
backupName=${USER}_${systemName}_${today}_backup.tar.gz

echo creating $backupName of ${PWD}/CURRENT_FILES

backupPath=/mnt/disk1/data/backups/linux_backups/cj_thinkpad
ssh root@rhino "echo ${backupPath}/FULL/${backupName}" > /tmp/backup_filename.log
ssh root@rhino "tar --use-compress-program='pigz -k ' -cvf $backupPath/FULL/$backupName $backupPath/CURRENT_FILES/"

ssh root@rhino "find ${backupPath}/FULL/ -type f -printf '%T@\t%p\n' | sort -t $'\t' -g | head -n -3 | cut -d $'\t' -f 2- | xargs rm"
