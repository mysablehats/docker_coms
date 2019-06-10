#!/usr/bin/env bash
# adds the keys to each machine defined in the local hosts file.
# needs expect (sudo apt install expect)

bash ./addroute.sh
#DOCKERMACHINEPORT=22
SSHKNOWHOSTSPATH=~/.ssh/known_hosts
export HOSTALIASES=$PWD/hosts
while IFS='' read -r line || [[ -n "$line" ]]; do
    #echo "Text read from file: $line"

    set $line ### this will put words into $1, $2, etc...
    MACHINEHOSTNAME=$1
    DOCKERMACHINEIP=$2
    DOCKERMACHINEPORT=$3
    #echo "the ip is $1 and the name is $2 "
    if [[ -z `ssh-keygen -H -F $MACHINEHOSTNAME` ]]
    then
      echo -e "keys not found for $MACHINEHOSTNAME"
      ssh-keygen -f "${SSHKNOWHOSTSPATH}" -R $MACHINEHOSTNAME
      ssh-keygen -f "${SSHKNOWHOSTSPATH}" -R $DOCKERMACHINEIP
      ./firstlogin.expect $DOCKERMACHINEIP $MACHINEHOSTNAME $DOCKERMACHINEPORT &
      wait %1
    fi
done < hosts
