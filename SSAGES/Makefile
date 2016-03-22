
### USER SETTINGS

# CXX = g++
CXX = g++-5

SSAGES_CODE  = $(HOME)/proj/SSAGES/code
SSAGES_BUILD = $(HOME)/proj/SSAGES/build

LAMMPS = $(HOME)/proj/SSAGES/lammps-10Aug15/src

MPI =  $(HOME)/sfw/mpich-master
TCL = $(HOME)/sfw/tcl-8.6.0
# TCL_VERSION = 8.5
TCL_VERSION = 8.6
TCLSH  = $(TCL)/bin/tclsh$(TCL_VERSION)
SHARED = -shared

SSAGES_INCLUDES = -I$(SSAGES_CODE)/src

### DERIVED SETTINGS

CPPFLAGS = -I$(MPI)/include -I$(TCL)/include $(SSAGES_INCLUDES)
CXXFLAGS = -std=gnu++11 -fPIC -g -O0 -Wall

LIBS :=
LIBS += -L$(SSAGES_BUILD) -lssages
LIBS += -L$(LAMMPS) -llammps_mpi -lboost_mpi

### BUILD RULES

all: pkgIndex.tcl

# Generate Tcl extension (C++) for contents of SSAGES.i
MockMethod_wrap.cxx: SSAGES.i
	swig -c++ -o $(@)   \
		$(SSAGES_INCLUDES) \
		$(<)
	sed -i s/Ssages_Init/Tclssages_Init/ $(@)

# Basic compilation rule
%.o: %.cxx
	$(CXX) -c -o $(@)   \
		$(CPPFLAGS) \
		$(CXXFLAGS) \
		$(<)

# Link the shared library loadable by Tcl
libtclssages.so: MockMethod_wrap.o
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

doc: README.html
README.html: README.adoc
	$(ASCIIDOC) $(<)

### CLEAN

clean:
	rm -fv pkgIndex.tcl *.so *.o MockMethod_wrap.cxx
	rm -fv *.html
