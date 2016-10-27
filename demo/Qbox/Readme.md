
# Swift interface to Qbox

This module is an initial Swift interface to the Qbox Context class,
allowing Swift to dynamically construct communicators as part of a
workflow and hand them to Qbox for execution.

To get this to work, you need the minor modification to Qbox provided in `qbox-1.63.5-swift.diff`

# Contents:

* `Makefile`: Builds the Qbox interface.  Edit for your system and type `make`.  The Makefile uses:
** `qbox.i`: A SWIG interface file for Qbox
* `qbox.swift`: A Swift header for the Qbox interface
* `workflow.swift`: An initial workflow file that simply creates one Qbox context on a communicator of size 2
* `qbox.tcl`: Some Tcl glue code
* `make-package.tcl`: Boilerplate script to make the Swift package
* `qbox-1.63.5-swift.diff`: The patch against Qbox 1.63.5 to make a shared library

# Usage:

```
$ make
...
$ swift-t -r $PWD -n 3 workflow.swift
New Context on: 1/2
New Context on: 0/2
```
