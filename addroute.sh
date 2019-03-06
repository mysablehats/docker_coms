#!/usr/bin/env bash

ALLDEFAULTNICS=`route | grep '^default' | grep -o '[^ ]*$'`
set $ALLDEFAULTNICS
THISPCNIC=$1

while IFS='' read -r line || [[ -n "$line" ]]; do
  #maybe I should read comment marks here to allow some description in those files?
  set $line
  DOCKERPCNAME=$1
  DOCKERPCIP=$2
  DOCKERNET=$3
  DOCKERNETMASK=$4

  MYRULE=`ip route | grep ${DOCKERNET}`

  if [ -z "${MYRULE}" ]
  then
        echo "Routing rule not found. Will add one"
        printf 'default nics found:\n%s\nWill add rule for %s, hope I am not making a mistake!\n' "$ALLDEFAULTNICS" "$THISPCNIC"
        sudo ip route add ${DOCKERNET}/${DOCKERNETMASK} via ${DOCKERPCIP} dev ${THISPCNIC}
  else
        printf 'Routing rule found. Will not update it. Remove it by hand if you want to reset it, before running this script with\nsudo ip route del %s/%s\n' "${DOCKERNET}" "${DOCKERNETMASK}"
  fi
done < dockerhosts
#sudo ip route
