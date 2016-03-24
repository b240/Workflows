
////
This is an Asciidoc file
Edit README.adoc.m4, not README.adoc
Build with 'make doc'
We use m4 include() instead of Asciidoc include because we want to do
the includes locally, not on GitHub
////

= SSAGES Interface for Swift/T

This currently builds a Swift/T leaf function for SSAGES via a Tcl
interface.

== Usage

. Build the Tcl package
// Swift leaf function
+
----
$ edit Makefile
$ make
----
+
. Check that the Tcl functions are there
+
----
$ ./scan.tcl
m4_include(scan.out)
----
. All of these functions may be called in parallel from Swift/T!
+
. Run Swift/T!
+
----
$ ./test.sh
m4_include(test.out)
----

== File index

+Makefile+:: Runs SWIG, builds the Tcl package (well commented)

+SSAGES.i+:: The SWIG interface file (well commented).  Wraps SSAGES for use by Tcl

+make-package.tcl+:: Makes the SSAGES package for Tcl

+scan.tcl+:: Checks what SSAGES functions are in the Tcl package

+ssages.tcl+:: Tcl glue code between Swift and the SWIG-generated extensions

+ssages.swift+:: Swift/T leaf function header containing SSAGES API

+test.sh+:: User interface to run Swift/T

+test.swift+:: Simple Swift/T test to call into SSAGES

+utils.{h,cpp}+:: C++ glue code.  Currently just an +MPI_Comm+ &rarr;
+boost::mpi::communicator+ function

== Boost notes

* Be sure that LAMMPS, SSAGES, and the SSAGES Tcl Interface are using the same Boost.
* To build Boost 1.60 from source, just do:
+
----
./bootstrap.sh
./b2 --with-mpi
----
+
* Tell SSAGES about this installation with, e.g.:
+
----
cmake ... -DBOOST_ROOT=/tmp/boost_1_60_0
----

== Software versions

Wozniak is currently testing with:

* G++ 4.9.3 (APT)
* Boost 1.6.0 (source)
* OpenMPI 1.6.5-8 (APT)
* LAMMPS 10Aug15 (built by SSAGES)

////
Local Variables:
mode: doc
End:
////
