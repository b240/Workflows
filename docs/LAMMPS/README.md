
<!--- You can render this as PDF with pandoc -->

# LAMMPS Docs

This documents how to run LAMMPS workflows under Swift/T on the Blue Gene/Q.

# Swift/T 

Swift/T is a workflow language.  It is documented here: 

http://swift-lang.org/Swift-T

# Setup

Add Swift/T to your `PATH`:

```
$ PATH=/soft/workflows/swift/T/stc/bin:$PATH
```

Run with:
```
export MODE=BGQ
export PROJECT=<project_name>
export QUEUE=<queue_name>
swift-t -m cobalt -n 3 program.swift
```

Further information about running on the Blue Gene/Q is here:

http://swift-lang.org/Swift-T/turbine-sites.html#_blue_gene_q

