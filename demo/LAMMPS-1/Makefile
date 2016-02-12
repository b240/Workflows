
# Builds the LAMMPS module for Swift/T

# Edit these paths and settings:
# CXX    = g++
MPI    = # $(HOME)/sfw/mpich-master
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

all: sanity pkgIndex.tcl seni.tcl

pkgIndex.tcl: libtcllammps.so
	LEAF_PKG=lammps LEAF_VERSION=0.0 \
	LEAF_SO=$(<) LEAF_TCL=lammps.tcl \
	$(TCLSH) ./make-package.tcl > $(@)

lammps_wrap.cpp: lammps.i
	swig -c++ -o $(@) -I$(LAMMPS) $(<)
	sed -i s/Lammps_Init/Tcllammps_Init/ $(@)

libtcllammps.so: lammps_wrap.o
	$(CXX) $(SHARED) -o $(@) $(^) $(LIBS) $(RPATHS)

seni.tcl: seni.swift lammps.swift
	stc -r $(PWD) $(<)

sanity: .timestamp

.timestamp: Makefile
	@echo MAKEFILE CHANGED
	make clean
	touch .timestamp
	@echo

clean:
	@echo CLEAN
	@rm -fv simple.tcl pkgIndex.tcl libtcllammps.so
	@rm -fv *.o
	@rm -fv lammps_wrap.cpp
	@rm -fv .timestamp

.PHONY: sanity clean
