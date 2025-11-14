// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VPCsrc_MUX.h for the primary calling header

#include "verilated.h"

#include "VPCsrc_MUX__Syms.h"
#include "VPCsrc_MUX___024root.h"

void VPCsrc_MUX___024root___ctor_var_reset(VPCsrc_MUX___024root* vlSelf);

VPCsrc_MUX___024root::VPCsrc_MUX___024root(VPCsrc_MUX__Syms* symsp, const char* name)
    : VerilatedModule{name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VPCsrc_MUX___024root___ctor_var_reset(this);
}

void VPCsrc_MUX___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

VPCsrc_MUX___024root::~VPCsrc_MUX___024root() {
}
