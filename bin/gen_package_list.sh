#!/bin/bash
#
# records all local package sources and installed packages
# to simplify environment setup on a new machine

package_dir=package_log

if [ $# -eq 1 ]
then
    package_dir=$1
fi

echo "Saving list of installed packages to $package_dir"

mkdir -p $package_dir
cp -R /etc/apt/sources.list.d $package_dir

packages=$(grep -i 'CommandLine: apt-get install ' /var/log/apt/history.log   | sed -e 's/Commandline: apt-get install//g' -e 's/\s-[[:alpha:]]*//g' | uniq)

echo "$packages" > $package_dir/package-list

