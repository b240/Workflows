
#include "utils.h"

boost::mpi::communicator* new_boost_comm(MPI_Comm comm)
{
  return new boost::mpi::communicator(comm, boost::mpi::comm_attach);
}

void delete_boost_comm(boost::mpi::communicator* boost_comm)
{
  delete boost_comm;
}
