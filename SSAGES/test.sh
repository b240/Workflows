#!/bin/sh

export SWIFT_PATH=$PWD
export TURBINE_LOG=0

export LD_LIBRARY_PATH=$HOME/sfw/boost_1_60_0/stage/lib

swift-t test.swift
