
# SSAGES.TCL

namespace eval ssages {

  proc ssages { args } {

    set outputs [ lindex $args 0 ]
    set inputs  [ lindex $args 1 ]

    if { [ llength $args ] > 2 } {
      set parallelism [ lindex $args 3 ]
      set par_arg "parallelism $parallelism"
    } else {
      set par_arg ""
    }

    rule [ list ] "ssages::ssages_body" \
        type $turbine::WORK {*}$par_arg
  }

  proc ssages_body { } {
    set comm [ turbine::c::task_comm ]
    puts "The MPI_Comm from Swift as an integer: $comm"
    set boost_comm [ SSAGES_new_boost_comm $comm ]
    puts "Converted to boost::mpi::communicator: $boost_comm"
    set MM [ new_SSAGES_MockMethod $boost_comm $boost_comm 1 ]
    puts "The MockMethod object: $MM"
    # Delete the heap-allocated boost::mpi::communicator:
    SSAGES_delete_boost_comm $boost_comm
  }
}
