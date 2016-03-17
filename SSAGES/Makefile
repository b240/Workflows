
SSAGES_HOME = $(HOME)/proj/SSAGES

MPI =  $(HOME)/sfw/mpich-master
# TCL    = $(HOME)/Public/tcl-8.5.12-bgq
# TCL_VERSION = 8.5
TCL    = $(HOME)/sfw/tcl-8.6.0
TCL_VERSION = 8.6
TCLSH  = $(TCL)/bin/tclsh$(TCL_VERSION)
SHARED = -shared

SSAGES_INCLUDES = -I$(SSAGES_HOME)/src

CPPFLAGS = -I$(MPI)/include -I$(TCL)/include $(SSAGES_INCLUDES) 

all: pkgIndex.tcl

MockMethod_wrap.cxx: SSAGES.i
	swig -c++ -o $(@)   \
		$(SSAGES_INCLUDES) \
		$(<)
	sed -i s/Ssages_Init/Tclssages_Init/ $(@)

%.o: %.cxx
	$(CXX) $(CPPFLAGS) -c -o $(@) $(<)

pkgIndex.tcl: libtclssages.so
	LEAF_PKG=ssages LEAF_VERSION=0.0 \
	LEAF_SO=$(<) LEAF_TCL=ssages.tcl \
	$(TCLSH) ./make-package.tcl > $(@)

libtclssages.so: MockMethod_wrap.o
	$(CXX) $(SHARED) -o $(@) $(^) $(LIBS) $(RPATHS)
