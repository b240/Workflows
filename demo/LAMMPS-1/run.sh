#!/bin/sh
set -eu

PATH=/home/wozniak/Public/sfw/ppc64/swift-t-git/stc/bin:$PATH

export MODE=BGQ QUEUE=default PROJECT=CES_Analysis
export SWIFT_PATH=$PWD
swift-t -m cobalt -n 8 seni.swift --data=$PWD/lammps_test
