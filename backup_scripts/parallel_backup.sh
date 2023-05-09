# /bin/bash
echo beginning rsync command



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
cd $source
find . -type f |
  parallel --bar --verbose -j10 -X rsync -Ra "${BACKUP_EXCLUDES[@]}" ./{} $target 
#ls $source | xargs -n1 -P4 -I% rsync -Pa % $target

}

remoteRoot=root@rhino:/mnt/disk1/data/backups/linux_backups/cj_thinkpad/CURRENT_FILES/root

parallel_rsync /home/cj/Desktop/deduped_fam_photos/ ${remoteRoot}/home/cj/Desktop/deduped_fam_photos/

exclude /deduped_fam_photos
parallel_rsync /home/cj/Desktop/ ${remoteRoot}/home/cj/Desktop/

BACKUP_EXCLUDES=()
exclude /Desktop
parallel_rsync /home/cj/ ${remoteRoot}/home/cj/

BACKUP_EXCLUDES=()
exclude /home/cj
parallel_rsync / ${remoteRoot}/

systemName=$(cat /etc/hostname)
today=$(date +%F)
export backupName=${USER}_${systemName}_${today}_backup.tar.gz

#ssh root@rhino "backupName=${backupName@Q} /bin/bash -s" < /home/cj/Desktop/backup_scripts/cleanup_remote.sh
