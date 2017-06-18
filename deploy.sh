#!/bin/bash

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

files=$(git ls-tree --name-only --full-tree HEAD | grep -v deploy.sh | grep -v grep)

#echo files
#echo "$files"


backup_files=$(echo $files | sed "s|\./|$homedir/|g")

#echo Deploying the following files to $homedir
#echo "backups are $backup_files"

backupfile=/tmp/dotfile-deploy-backup-$(date +%s).tar

echo "Backing up files to $backupfile..."

tar  --ignore-failed-read -cvf $backupfile $backup_files

echo "Installing files: "

for file in $files
do
    path=$homedir/$file
    if [ ! -d $(dirname $path) ]
    then
	echo "$(dirname $path)"
#	mkdir $(dirname $path)
    fi

    echo "$path"
    #    cp $file $path
    rm -f $path
    ln -s $PWD/$file $path
done

#backup files
