#!/usr/bin/env bash


DOCKERPCIP=10.0.0.7
THISPCNIC=enp8s0
DOCKERNET=172.0.0.0
DOCKERNETMASK=8

MYRULE=`ip route | grep ${DOCKERNET}`

if [ -z "${MYRULE}" ]
then
      echo "Routing rule not found. Will add one"
      sudo ip route add ${DOCKERNET}/${DOCKERNETMASK} via ${DOCKERPCIP} dev ${THISPCNIC}
else
      echo -e "Routing rule found. Will not update it. Remove it by hand if you want to reset it, before running this script with\nsudo ip route del ${DOCKERNET}/${DOCKERNETMASK}"
fi

#sudo ip route
