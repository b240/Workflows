#!/bin/bash -e

N=$1
DIR=$2

usage()
{
  echo "usage: setup.sh N DIR"
}

if [[ -z ${N} ]] || [[ -z ${DIR} ]]
then
  usage
  exit 1
fi

FILTER=${DIR}/input.inp.filter

for (( i=0 ; i < N ; i++ ))
do
  t=$(( 300+i ))
  INPUT_FILE=${DIR}/input-${t}.inp
  echo "creating: ${INPUT_FILE}"
  sed "s/_TEMPERATURE_/${t}/g" ${FILTER} > ${INPUT_FILE}
done
