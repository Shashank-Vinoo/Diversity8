// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VALU.h for the primary calling header

#include "verilated.h"

#include "VALU___024root.h"

VL_INLINE_OPT void VALU___024root___combo__TOP__0(VALU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU___024root___combo__TOP__0\n"); );
    // Body
    vlSelf->EQ = (vlSelf->ALU_Op1 == vlSelf->ALU_Op2);
    vlSelf->ALU_out = ((4U & (IData)(vlSelf->ALUctrl))
                        ? ((2U & (IData)(vlSelf->ALUctrl))
                            ? 0U : ((1U & (IData)(vlSelf->ALUctrl))
                                     ? ((vlSelf->ALU_Op1 
                                         < vlSelf->ALU_Op2)
                                         ? 1U : 0U)
                                     : 0U)) : ((2U 
                                                & (IData)(vlSelf->ALUctrl))
                                                ? (
                                                   (1U 
                                                    & (IData)(vlSelf->ALUctrl))
                                                    ? 
                                                   (vlSelf->ALU_Op1 
                                                    | vlSelf->ALU_Op2)
                                                    : 
                                                   (vlSelf->ALU_Op1 
                                                    & vlSelf->ALU_Op2))
                                                : (
                                                   (1U 
                                                    & (IData)(vlSelf->ALUctrl))
                                                    ? 
                                                   (vlSelf->ALU_Op1 
                                                    - vlSelf->ALU_Op2)
                                                    : 
                                                   (vlSelf->ALU_Op1 
                                                    + vlSelf->ALU_Op2))));
}

void VALU___024root___eval(VALU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU___024root___eval\n"); );
    // Body
    VALU___024root___combo__TOP__0(vlSelf);
}

#ifdef VL_DEBUG
void VALU___024root___eval_debug_assertions(VALU___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VALU__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VALU___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->ALUctrl & 0xf8U))) {
        Verilated::overWidthError("ALUctrl");}
}
#endif  // VL_DEBUG
