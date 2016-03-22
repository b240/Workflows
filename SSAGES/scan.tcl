#!/usr/bin/env tclsh

lappend auto_path $env(PWD)

package require ssages 0.0

set cmds [ info commands ]

set L [list]

foreach cmd $cmds {
  if [ regexp .*SSAGES.* $cmd ] { 
    lappend L $cmd
  }
}

set L [ lsort $L ]
foreach cmd $L {
    puts $cmd
}
