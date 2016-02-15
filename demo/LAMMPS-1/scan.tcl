#!/usr/bin/env tclsh8.5

# Note: This does not work on the BG/Q because we cannot load
# MPI and thus LAMMPS on the login nodes

lappend auto_path $env(PWD)

package require lammps 0.0

set cmds [ info commands ]

set L [list]

foreach cmd $cmds {
    if { [ regexp .*LAMMPS.* $cmd ] || \
         [ regexp .*Input.* $cmd ] } {
        lappend L $cmd
    }
}

set L [ lsort $L ]
foreach cmd $L {
    puts $cmd
}
