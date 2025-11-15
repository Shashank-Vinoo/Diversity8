// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VALU_Src_Mux.h for the primary calling header

#include "verilated.h"

#include "VALU_Src_Mux___024root.h"

VL_INLINE_OPT void VALU_Src_Mux___024root___combo__TOP__0(VALU_Src_Mux___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU_Src_Mux__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU_Src_Mux___024root___combo__TOP__0\n"); );
    // Body
    vlSelf->ALUOp2 = ((IData)(vlSelf->ALUsrc) ? vlSelf->ImmOp
                       : vlSelf->regOp2);
}

void VALU_Src_Mux___024root___eval(VALU_Src_Mux___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU_Src_Mux__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU_Src_Mux___024root___eval\n"); );
    // Body
    VALU_Src_Mux___024root___combo__TOP__0(vlSelf);
}

#ifdef VL_DEBUG
void VALU_Src_Mux___024root___eval_debug_assertions(VALU_Src_Mux___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU_Src_Mux__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU_Src_Mux___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->ALUsrc & 0xfeU))) {
        Verilated::overWidthError("ALUsrc");}
}
#endif  // VL_DEBUG
