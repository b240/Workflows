
%module lammps

%include <lammps.h>
%include <input.h>

typedef int MPI_Comm;

typedef LAMMPS_NS::Input Input;

%{
#include <mpi.h>
#include <lammps.h>
#include <input.h>
using namespace LAMMPS_NS;
%}
