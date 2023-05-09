# /bin/bash
echo beginning rsync command
base=root@rhino:/mnt/disk1/data/backups/linux_backups/cj_thinkpad

source=/home/cj
base=root@rhino:/mnt/disk1/data/backups/linux_backups/cj_thinkpad
target=root@rhino:/mnt/disk1/data/backups/linux_backups/cj_thinkpad/cur

prepare_files(){
source=$1
# create files if dont exist
touch /tmp/parentlist
touch /tmp/filelist


find ${source}/./ -maxdepth 5 -type d | perl -pe 's|^.*?/\./|\1|' > /tmp/rawfilelist
# get list of files within directory limit to copy non recursively
cp /tmp/rawfilelist /tmp/parentslist
cp /tmp/rawfilelist /tmp/filelist
sed -i '/^\(.*\/\)\{4\}.*$/d' /tmp/parentlist
sed -i '/^\(.*\/\)\{4\}.*$/!d' /tmp/filelist
}

parallel_rsync() {
source=$1
target=$2

prepare_files $source
# rsync parents
cat /tmp/parentlist | parallel -j 3 'shopt -s dotglob; rsync -aHvx --no-r --relative /tmp/${source}/./{}/* /tmp/${target}/'

# rsync more nested directories
cat /tmp/filelist | parallel -j 10 rsync -aHvx --relative ${source}/./{} ${target}

# catch anything else
rsync -aHvx --delete ${source}/ ${target}
}

find ${source}/./ -maxdepth 5 -type d | perl -pe 's|^.*?/\./|\1|' > /tmp/rawfilelist
# get list of files within directory limit to copy non recursively
cp /tmp/rawfilelist /tmp/parentslist
cp /tmp/rawfilelist /tmp/filelist
sed -i '/^\(.*\/\)\{4\}.*$/d' /tmp/parentlist
sed -i '/^\(.*\/\)\{4\}.*$/!d' /tmp/filelist

# rsync parents
cat /tmp/parentlist | parallel -j 3 'shopt -s dotglob; rsync -aHvx --no-r --relative /tmp/${source}/./{}/* /tmp/${target}/'

# rsync more nested directories
cat /tmp/filelist | parallel -j 10 rsync -aHvx --relative ${source}/./{} ${target}

# catch anything else
rsync -aHvx --delete ${source}/ ${target}


#rsync -av --delete --exclude=Desktop --exclude=.cache /home/cj/ ${base}/CURRENT_FILES/home/ &
#rsync -av --delete /home/cj/Desktop/deduped_fam_photos/ ${base}/CURRENT_FILES/fam_photos/ &
#rsync -av --delete /home/cj/Desktop/unraid_backup/ ${base}/CURRENT_FILES/unraid_backup/ &
#rsync -av --delete --exclude=pycharm-community-2023.1 --exclude=deduped_fam_photos --exclude=unraidBackup /home/cj/Desktop/ ${base}/CURRENT_FILES/Desktop/

systemName=$(cat /etc/hostname)
today=$(date +%F)
export backupName=${USER}_${systemName}_${today}_backup.tar.gz

#ssh root@rhino "backupName=${backupName@Q} /bin/bash -s" < /home/cj/Desktop/backup_scripts/cleanup_remote.sh
