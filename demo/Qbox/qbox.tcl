
namespace eval qbox {

    proc qbox { args } {

        set outputs     [ lindex $args 0 ]
        set inputs      [ lindex $args 1 ]

        if { [ llength $args ] > 2 } {
            set parallelism [ lindex $args 3 ]
            set par_arg "parallelism $parallelism"
        } else {
            set par_arg ""
        }

        rule [ list ] "qbox::qbox_body" \
            type $turbine::WORK {*}$par_arg
    }
    proc qbox_body { } {

        # This is an MPI_Comm
        set comm [ turbine::c::task_comm ]

        set comm [ blobutils_cast_to_ptr $comm ]

        # Call QBOX main control sequence (cf. QBOX main.cpp)
        set ctx [ new_Context $comm ]
        delete_Context $ctx
    }
}
