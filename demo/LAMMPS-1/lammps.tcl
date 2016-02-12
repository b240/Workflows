
namespace eval lammps {

    proc lammps { args } {

        set outputs     [ lindex $args 0 ]
        set inputs      [ lindex $args 1 ]

        set d [ lindex $inputs 0 ]
        set a [ lindex $inputs 1 ]

        if { [ llength $args ] > 2 } {
            set parallelism [ lindex $args 3 ]
            set par_arg "parallelism $parallelism"
        } else {
            set par_arg ""
        }

        rule [ list $d $a ] "lammps::lammps_body $d $a" \
            type $turbine::WORK {*}$par_arg
    }
    proc lammps_body { d a } {

        set d_value [ retrieve $d ]
        set a_value [ retrieve $a ]

        cd $d_value

        set lammps_argc [ llength $a_value ]
        # In accordance with Unix argument counting conventions:
        incr lammps_argc
        set bytes [ expr $lammps_argc * [blobutils_sizeof_ptr] ]
        # This is a void*
        set alloc [ blobutils_malloc $bytes ]
        # This is a char**
        set lammps_argv [ blobutils_cast_to_char_ptrptr $alloc ]

        # Fill in argv...
        # This is a void**
        set v [ blobutils_cast_to_ptrptr $alloc ]
        # Set argv[0] to dummy value (or LAMMPS will crash)
        set p [ blobutils_cast_string_to_ptr "TURBINE" ]
        blobutils_set_ptr $v 0 $p
        # Set rest of arguments...
        set i 1
        foreach s $a_value {
            set p [ blobutils_cast_string_to_ptr $s ]
            blobutils_set_ptr $v $i $p
            incr i
        }

        # This is an MPI_Comm
        set comm [ turbine::c::task_comm ]

        # Call LAMMPS main control sequence (cf. LAMMPS main.cpp)
        set L [ new_LAMMPS $lammps_argc $lammps_argv $comm ]
        set input [ LAMMPS_input_get $L ]
        Input_file $input
        delete_LAMMPS $L
    }
}
