# /bin/bash
BACKUP_EXCLUDES=()                                                                                                                                                                                                                            
function exclude
{
  while
    (( $# ))
  do
    BACKUP_EXCLUDES+=(--exclude="$1")
    shift
  done
}


parallel_rsync() {                                                                                                                                                                                                                            
    source=$1
    target=$2

    echo source $source
    echo target $target
    #find . -type f |
    #  parallel --bar --verbose -j10 -X rsync -Ra "${BACKUP_EXCLUDES[@]}" ./{} $target 

    rsync -arv $source $target
    #rsync -aPv $source $target
}

echo ls -l root@rhino:/mnt/docker/appdata
rsync -av root@rhino:/mnt/docker/appdata/ /home/cj/Desktop/unraidBackup/CURRENT_FILES/mnt/docker/appdata/

systemName=$(cat /etc/hostname)                                                                                                                                                                                                               
today=$(date +%F)
backupName=${USER}_${systemName}_${today}_backup.tar.gz

echo creating $backupName of ${PWD}/CURRENT_FILES

backupPath=/home/cj/Desktop/unraidBackup
echo ${backupPath}/FULL/${backupName} > /tmp/backup_filename.log
tar -zcvf ${backupPath}/FULL/${backupName} ${backupPath}/CURRENT_FILES/

echo Deleting files $(ls -1t ${backupPath}/FULL/ | tail -n +3)
rm -f $(ls -1t ${backupPath}/FULL/ | tail -n +3)

