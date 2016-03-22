
// Package name
%module SSAGES

// Prefix all functions with "SSAGES_"- ease of identification
// See also scan.tcl
%rename("SSAGES_%s") "";

// These headers are scanned by SWIG
// All functions are exposed to Tcl
%include <Methods/Method.h>
%include <Methods/MockMethod.h>

// This code is pasted into the Tcl extension
%{
#include <Methods/Method.h>
#include <Methods/MockMethod.h>
using namespace SSAGES;
%}
