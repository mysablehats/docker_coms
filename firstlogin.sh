#!/usr/bin/env bash
## each time you make a completely new docker machine this will happen...

###this kinda needs to be parametrized,

MACHINEHOSTNAME=tsn_caffe
DOCKERMACHINEIP=172.28.5.3
DOCKERMACHINEPORT=22
SSHKNOWHOSTSPATH=~/.ssh/known_hosts

ssh-keygen -f "${SSHKNOWHOSTSPATH}" -R $MACHINEHOSTNAME
ssh-keygen -f "${SSHKNOWHOSTSPATH}" -R $DOCKERMACHINEIP

ssh -oHostKeyAlgorithms='ssh-rsa' root@${MACHINEHOSTNAME} -p $DOCKERMACHINEPORT
