// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VALU_Src_Mux.h for the primary calling header

#ifndef VERILATED_VALU_SRC_MUX___024ROOT_H_
#define VERILATED_VALU_SRC_MUX___024ROOT_H_  // guard

#include "verilated.h"

class VALU_Src_Mux__Syms;

class VALU_Src_Mux___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(ALUsrc,0,0);
    VL_IN(regOp2,31,0);
    VL_IN(ImmOp,31,0);
    VL_OUT(ALUOp2,31,0);

    // INTERNAL VARIABLES
    VALU_Src_Mux__Syms* const vlSymsp;

    // CONSTRUCTORS
    VALU_Src_Mux___024root(VALU_Src_Mux__Syms* symsp, const char* name);
    ~VALU_Src_Mux___024root();
    VL_UNCOPYABLE(VALU_Src_Mux___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard
