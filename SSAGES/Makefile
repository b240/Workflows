
### USER SETTINGS

CXX = g++

SSAGES = $(HOME)/workspace-mars/SSAGES
SSAGES_CODE  = $(SSAGES)/code
SSAGES_BUILD = $(SSAGES)/build

LAMMPS = $(HOME)/proj/SSAGES/lammps-10Aug15/src

# MPI =  $(HOME)/sfw/mpich-master
# MPI_INCLUDE = $(MPI)/include
MPI_INCLUDE = /usr/include/mpi
TCL = $(HOME)/sfw/tcl-8.6.0
# TCL_VERSION = 8.5
TCL_VERSION = 8.6
TCLSH  = $(TCL)/bin/tclsh$(TCL_VERSION)
# BOOST = /tmp/boost_1_60_0
BOOST = $(HOME)/sfw/boost_1_60_0
BOOST_LIB = $(BOOST)/stage/lib

SHARED = -shared

SSAGES_INCLUDES = -I$(SSAGES_CODE)/src

### DERIVED SETTINGS

CPPFLAGS = -I$(MPI_INCLUDE) -I$(TCL)/include $(SSAGES_INCLUDES)
CXXFLAGS = -std=gnu++11 -fPIC -g -O0 -Wall

LIBS :=
LIBS += -L$(SSAGES_BUILD) -lssages
LIBS += -L$(LAMMPS)       -llammps_mpi
LIBS += -L$(BOOST_LIB)    -lboost_mpi

### BUILD RULES

all: pkgIndex.tcl

# Generate Tcl extension (C++) for contents of SSAGES.i
MockMethod_wrap.cpp: SSAGES.i
	swig -c++ -o $(@)          \
		$(SSAGES_INCLUDES) \
		$(<)
	sed -i 's/Ssages_Init/Tclssages_Init/' $(@)
	sed -i 's/static_cast< MPI_Comm >/(MPI_Comm)/' $(@)

# Basic compilation rule
%.o: %.cpp
	$(CXX) -c -o $(@)   \
		$(CPPFLAGS) \
		$(CXXFLAGS) \
		$(<)

# Link the shared library loadable by Tcl
libtclssages.so: MockMethod_wrap.o utils.o
	$(CXX) $(SHARED) -o $(@) \
		$(CXXFLAGS)      \
		$(^)             \
		$(LIBS)          \
		$(RPATHS)

# Create a Tcl package file
pkgIndex.tcl: libtclssages.so
	LEAF_PKG=ssages LEAF_VERSION=0.0 \
	LEAF_SO=$(<) LEAF_TCL=ssages.tcl \
	$(TCLSH) ./make-package.tcl > $(@)

### DOCS

ASCIIDOC = asciidoc --attribute stylesheet=$(PWD)/doc.css \
                    -a max-width=750px -a textwidth=80

# Do not delete the intermediate README.adoc !
# It is visible on GitHub

doc: README.html
README.html: README.adoc.m4 $(wildcard *.out)
	m4 --prefix-builtins $(<) > README.adoc
	$(ASCIIDOC) README.adoc

### CLEAN

clean:
	rm -fv pkgIndex.tcl *.so *.o MockMethod_wrap.cpp
	rm -fv *.html
