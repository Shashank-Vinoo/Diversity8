// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VPCsrc_MUX.h for the primary calling header

#include "verilated.h"

#include "VPCsrc_MUX___024root.h"

VL_INLINE_OPT void VPCsrc_MUX___024root___combo__TOP__0(VPCsrc_MUX___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root___combo__TOP__0\n"); );
    // Body
    vlSelf->next_PC = ((IData)(vlSelf->PCsrc) ? vlSelf->branch_PC
                        : vlSelf->inc_PC);
}

void VPCsrc_MUX___024root___eval(VPCsrc_MUX___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root___eval\n"); );
    // Body
    VPCsrc_MUX___024root___combo__TOP__0(vlSelf);
}

#ifdef VL_DEBUG
void VPCsrc_MUX___024root___eval_debug_assertions(VPCsrc_MUX___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->PCsrc & 0xfeU))) {
        Verilated::overWidthError("PCsrc");}
}
#endif  // VL_DEBUG
