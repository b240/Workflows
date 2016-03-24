
#pragma once

#include <boost/mpi.hpp>

boost::mpi::communicator* new_boost_comm(MPI_Comm comm);
void delete_boost_comm(boost::mpi::communicator* boost_comm);
