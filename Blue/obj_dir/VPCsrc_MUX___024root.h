// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VPCsrc_MUX.h for the primary calling header

#ifndef VERILATED_VPCSRC_MUX___024ROOT_H_
#define VERILATED_VPCSRC_MUX___024ROOT_H_  // guard

#include "verilated.h"

class VPCsrc_MUX__Syms;

class VPCsrc_MUX___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(PCsrc,0,0);
    VL_IN(branch_PC,31,0);
    VL_IN(inc_PC,31,0);
    VL_OUT(next_PC,31,0);

    // INTERNAL VARIABLES
    VPCsrc_MUX__Syms* const vlSymsp;

    // CONSTRUCTORS
    VPCsrc_MUX___024root(VPCsrc_MUX__Syms* symsp, const char* name);
    ~VPCsrc_MUX___024root();
    VL_UNCOPYABLE(VPCsrc_MUX___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
