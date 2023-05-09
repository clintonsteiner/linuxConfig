# /bin/bash
echo beginning rsync command
base=root@rhino:/mnt/disk1/data/backups/linux_backups/cj_thinkpad

rsync -av --delete --exclude=Desktop --exclude=.cache /home/cj/ ${base}/CURRENT_FILES/home/ &
rsync -av --delete /home/cj/Desktop/deduped_fam_photos/ ${base}/CURRENT_FILES/fam_photos/ &
rsync -av --delete /home/cj/Desktop/unraid_backup/ ${base}/CURRENT_FILES/unraid_backup/ &
rsync -av --delete --exclude=pycharm-community-2023.1 --exclude=deduped_fam_photos --exclude=unraidBackup /home/cj/Desktop/ ${base}/CURRENT_FILES/Desktop/

systemName=$(cat /etc/hostname)
today=$(date +%F)
export backupName=${USER}_${systemName}_${today}_backup.tar.gz

ssh root@rhino "backupName=${backupName@Q} /bin/bash -s" < /home/cj/Desktop/backup_scripts/cleanup_remote.sh
