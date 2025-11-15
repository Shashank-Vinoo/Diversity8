// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VRegFile.h for the primary calling header

#ifndef VERILATED_VREGFILE___024ROOT_H_
#define VERILATED_VREGFILE___024ROOT_H_  // guard

#include "verilated.h"

class VRegFile__Syms;

class VRegFile___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(WE3,0,0);
    VL_IN8(AD1,4,0);
    VL_IN8(AD2,4,0);
    VL_IN8(AD3,4,0);
    CData/*0:0*/ __Vclklast__TOP__clk;
    VL_IN(WD3,31,0);
    VL_OUT(RD1,31,0);
    VL_OUT(RD2,31,0);
    VL_OUT(a0,31,0);
    VlUnpacked<IData/*31:0*/, 32> RegFile__DOT__registers;

    // INTERNAL VARIABLES
    VRegFile__Syms* const vlSymsp;

    // CONSTRUCTORS
    VRegFile___024root(VRegFile__Syms* symsp, const char* name);
    ~VRegFile___024root();
    VL_UNCOPYABLE(VRegFile___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
