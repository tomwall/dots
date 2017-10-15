#!/bin/bash -e

homedir=$HOME

if [ $# -eq 1 ]
then
    homedir=$1
fi

if [ ! -d $homedir ]
then
    echo Error: target dir $homedir does not exist.
    exit 1
fi

files=$(git ls-tree --name-only --full-tree HEAD | grep -v $(basename $0) | grep -v README | grep -v grep)
backup_files=$(echo $files | sed "s|\./|$homedir/|g")
backupfile=/tmp/dotfile-deploy-backup-$(date +%s).tar

echo "Backing up files to $backupfile..."
tar  --ignore-failed-read -cvf $backupfile $backup_files > /dev/null

echo "Deploying files..."
for file in $files
do
    path=$homedir/$file  
    echo "$path"
    rm -f $path
    ln -s $PWD/$file $path
done
