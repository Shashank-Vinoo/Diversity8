// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "VPCsrc_MUX__Syms.h"
#include "VPCsrc_MUX.h"
#include "VPCsrc_MUX___024root.h"

// FUNCTIONS
VPCsrc_MUX__Syms::~VPCsrc_MUX__Syms()
{
}

VPCsrc_MUX__Syms::VPCsrc_MUX__Syms(VerilatedContext* contextp, const char* namep, VPCsrc_MUX* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
{
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-12);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
}
