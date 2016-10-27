
# Builds the Qbox module for Swift/T

# Edit these paths and settings:
MPI    = # $(HOME)/sfw/mpich-master
# MPI    = /bgsys/drivers/V1R2M1/ppc64/comm
CXX    = mpicxx.openmpi
QBOX = $(HOME)/Downloads/qbox-1.63.5/src
TCL    = /data/sfw/tcl-8.6.0
# TCL_VERSION = 8.5
TCL_VERSION = 8.6
TCLSH  = $(TCL)/bin/tclsh$(TCL_VERSION)
SHARED = -shared

QBOX_BUILD = $(QBOX)

INCLUDES := -I $(QBOX)
INCLUDES += -I $(TCL)/include
# INCLUDES += -I $(MPI)/include

FLAGS = -g -fPIC -Wall

CXXFLAGS += $(FLAGS) $(INCLUDES)

LIBS := -L $(QBOX_BUILD) -l qb
LIBS += -L$(TCL)/lib -l tcl$(TCL_VERSION)
LIBS += -l xerces-c -l scalapack-openmpi -lmpi_cxx -lmpi

RPATHS := -Wl,-rpath -Wl,$(QBOX_BUILD)
RPATHS += -Wl,-rpath -Wl,$(TCL)/lib
# RPATHS += -Wl,-rpath -Wl,$(MPI)/lib

.DELETE_ON_ERROR:

all: pkgIndex.tcl

pkgIndex.tcl: libtclqbox.so
	LEAF_PKG=qbox LEAF_VERSION=0.0 \
	LEAF_SO=$(<) LEAF_TCL=qbox.tcl \
	$(TCLSH) ./make-package.tcl > $(@)

qbox_wrap.cpp: qbox.i
	swig -c++ -o $(@) -I$(QBOX) $(<)
	sed -i s/Qbox_Init/Tclqbox_Init/ $(@)

libtclqbox.so: qbox_wrap.o
	$(CXX) $(SHARED) -o $(@) $(FLAGS) $(^) \
		$(LIBS) \
		$(RPATHS)

clean:
	@rm -fv libtclqbox.so *.o
	@rm -fv pkgIndex.tcl qbox_wrap.cpp
#	Remove Swift/T stuff
	@rm -fv *.tic turbine-directory.txt

.PHONY: clean
