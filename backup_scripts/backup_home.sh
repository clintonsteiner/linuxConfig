# /bin/bash

remoteRoot=root@rhino:/mnt/disk1/data/backups/linux_backups/cj_thinkpad/CURRENT_FILES/root

rsync -avP --exclude=pycharm* --exclude=unraidBackup --exclude=*.tar* /home/cj/Desktop/ ${remoteRoot}/home/cj/Desktop/
rsync -avP --exclude=Desktop --exclude=.cache --exclude=.mozilla --exclude=.rustup /home/cj/ ${remoteRoot}/home/cj/

