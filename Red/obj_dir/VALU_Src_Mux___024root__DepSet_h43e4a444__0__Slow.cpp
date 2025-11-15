// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VALU_Src_Mux.h for the primary calling header

#include "verilated.h"

#include "VALU_Src_Mux___024root.h"

VL_ATTR_COLD void VALU_Src_Mux___024root___eval_initial(VALU_Src_Mux___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU_Src_Mux__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU_Src_Mux___024root___eval_initial\n"); );
}

void VALU_Src_Mux___024root___combo__TOP__0(VALU_Src_Mux___024root* vlSelf);

VL_ATTR_COLD void VALU_Src_Mux___024root___eval_settle(VALU_Src_Mux___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU_Src_Mux__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU_Src_Mux___024root___eval_settle\n"); );
    // Body
    VALU_Src_Mux___024root___combo__TOP__0(vlSelf);
}

VL_ATTR_COLD void VALU_Src_Mux___024root___final(VALU_Src_Mux___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU_Src_Mux__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU_Src_Mux___024root___final\n"); );
}

VL_ATTR_COLD void VALU_Src_Mux___024root___ctor_var_reset(VALU_Src_Mux___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU_Src_Mux__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU_Src_Mux___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->regOp2 = VL_RAND_RESET_I(32);
    vlSelf->ImmOp = VL_RAND_RESET_I(32);
    vlSelf->ALUsrc = VL_RAND_RESET_I(1);
    vlSelf->ALUOp2 = VL_RAND_RESET_I(32);
}
