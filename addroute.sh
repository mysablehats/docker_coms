#!/usr/bin/env bash

ALLDEFAULTNICS=`route | grep '^default' | grep -o '[^ ]*$'`
set $ALLDEFAULTNICS

DOCKERPCIP=10.0.0.7
THISPCNIC=$1
DOCKERNET=172.0.0.0
DOCKERNETMASK=8

MYRULE=`ip route | grep ${DOCKERNET}`

if [ -z "${MYRULE}" ]
then
      echo "Routing rule not found. Will add one"
      printf 'default nics found:\n%s\nWill add rule for %s, hope I am not making a mistake!\n' "$ALLDEFAULTNICS" "$THISPCNIC"
      sudo ip route add ${DOCKERNET}/${DOCKERNETMASK} via ${DOCKERPCIP} dev ${THISPCNIC}
else
      printf 'Routing rule found. Will not update it. Remove it by hand if you want to reset it, before running this script with\nsudo ip route del %s/%s' "${DOCKERNET}" "${DOCKERNETMASK}"
fi

#sudo ip route
