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
    #find . -type f |
    #  parallel --bar --verbose -j10 -X rsync -Ra "${BACKUP_EXCLUDES[@]}" ./{} $target 
    pushd $source; ls -1 $source | xargs -I {} -P 0 -n 1 rsync -av --ignore-existing --delete "${BACKUP_EXCLUDES[@]}" ./{} $target; popd;

}

remoteRoot=root@rhino:/mnt/disk1/data/backups/linux_backups/cj_thinkpad/CURRENT_FILES/root

parallel_rsync /home/cj/Desktop/deduped_fam_photos/ ${remoteRoot}/home/cj/Desktop/deduped_fam_photos/

BACKUP_EXCLUDES=()
exclude /deduped_fam_photos /pycharm-community-2023.1 /unraidBackup
parallel_rsync /home/cj/Desktop/ ${remoteRoot}/home/cj/Desktop/

BACKUP_EXCLUDES=()
exclude /Desktop /.cache
parallel_rsync /home/cj/ ${remoteRoot}/home/cj/

ssh root@rhino "/bin/bash -s" < /home/cj/linuxConfig/backup_scripts/cleanup_remote.sh
