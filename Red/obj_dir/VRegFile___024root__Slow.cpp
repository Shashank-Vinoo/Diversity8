// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VRegFile.h for the primary calling header

#include "verilated.h"

#include "VRegFile__Syms.h"
#include "VRegFile___024root.h"

void VRegFile___024root___ctor_var_reset(VRegFile___024root* vlSelf);

VRegFile___024root::VRegFile___024root(VRegFile__Syms* symsp, const char* name)
    : VerilatedModule{name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VRegFile___024root___ctor_var_reset(this);
}

void VRegFile___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

VRegFile___024root::~VRegFile___024root() {
}
