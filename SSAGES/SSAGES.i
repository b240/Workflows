
%module SSAGES
%rename("SSAGES_%s") "";

 // %include "std_vector.i"

class EventListener;

%include <Methods/Method.h>
%include <Methods/MockMethod.h>

%{
#include <Methods/Method.h>
#include <Methods/MockMethod.h>
using namespace SSAGES;
%}
