
# Builds the LAMMPS module for Swift/T

# Edit these paths and settings:
# CXX    = g++
MPI    = # $(HOME)/sfw/mpich-master
# MPI    = /bgsys/drivers/V1R2M1/ppc64/comm
CXX    = mpicxx
# LAMMPS = $(HOME)/downloads/lammps-11Jul13/src
LAMMPS = $(HOME)/downloads/lammps-10Aug15/src
# TCL    = $(HOME)/sfw/tcl-8.6.0
# TCL    = $(HOME)/Public/tcl-8.5.12-bgq
TCL    = $(HOME)/Public/sfw/ppc64/bgxlc/dynamic/tcl-8.5.12
TCL_VERSION = 8.5
# TCL_VERSION = 8.6
TCLSH  = $(TCL)/bin/tclsh$(TCL_VERSION)
SHARED = -shared
# SHARED = -qmkshrobj

LAMMPS_BUILD = $(LAMMPS)

INCLUDES := -I $(LAMMPS)
INCLUDES += -I $(TCL)/include
# INCLUDES += -I $(MPI)/include

CXXFLAGS += $(INCLUDES)

LIBS := -L $(LAMMPS_BUILD) -l lammps
LIBS += -L$(TCL)/lib -l tcl$(TCL_VERSION)

RPATHS := -Wl,-rpath -Wl,$(LAMMPS_BUILD)
RPATHS += -Wl,-rpath -Wl,$(TCL)/lib
# RPATHS += -Wl,-rpath -Wl,$(MPI)/lib

.DELETE_ON_ERROR:

all: pkgIndex.tcl

pkgIndex.tcl: libtcllammps.so
	LEAF_PKG=lammps LEAF_VERSION=0.0 \
	LEAF_SO=$(<) LEAF_TCL=lammps.tcl \
	$(TCLSH) ./make-package.tcl > $(@)

lammps_wrap.cpp: lammps.i
	swig -c++ -o $(@) -I$(LAMMPS) $(<)
	sed -i s/Lammps_Init/Tcllammps_Init/ $(@)

libtcllammps.so: lammps_wrap.o
	$(CXX) $(SHARED) -o $(@) $(^) $(LIBS) $(RPATHS)

workflow.tic: workflow.swift lammps.swift
	stc -r $(PWD) $(<)

clean:
	@rm -fv libtcllammps.so *.o
	@rm -fv pkgIndex.tcl lammps_wrap.cpp
#	Remove Swift/T stuff
	@rm -fv *.tic turbine-directory.txt

.PHONY: clean
