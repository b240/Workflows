#!/bin/bash
set -eu

TARBALL=lmprun.tar.gz

if [[ -f ${TARBALL} ]]
then
  rm -v ${TARBALL}
fi

wget http://www.mcs.anl.gov/~wozniak/${TARBALL}
tar xfz ${TARBALL}
if [[ ! -d lammps_test ]]
then
  echo "ERROR: Something is wrong with the data set"
  exit 1
fi

exit 0
