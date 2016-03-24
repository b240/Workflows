
// Package name
%module SSAGES

// Prefix all functions with "SSAGES_"- ease of identification
// See also scan.tcl
%rename("SSAGES_%s") "";

// Type clarifications for SWIG
typedef int MPI_Comm;
class boost::mpi::communicator;

// These headers are scanned by SWIG
// All functions are exposed to Tcl
#define BOOST_MPI_DECL
%include <utils.h>
%include <Methods/Method.h>
%include <Methods/MockMethod.h>

// This code is pasted into the Tcl extension
%{
#include "utils.h"
#include <Methods/Method.h>
#include <Methods/MockMethod.h>
using namespace SSAGES;
%}
