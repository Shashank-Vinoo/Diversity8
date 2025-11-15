// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VALU_SRC_MUX__SYMS_H_
#define VERILATED_VALU_SRC_MUX__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "VALU_Src_Mux.h"

// INCLUDE MODULE CLASSES
#include "VALU_Src_Mux___024root.h"

// SYMS CLASS (contains all model state)
class VALU_Src_Mux__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    VALU_Src_Mux* const __Vm_modelp;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    VALU_Src_Mux___024root         TOP;

    // CONSTRUCTORS
    VALU_Src_Mux__Syms(VerilatedContext* contextp, const char* namep, VALU_Src_Mux* modelp);
    ~VALU_Src_Mux__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
