// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VPCsrc_MUX.h for the primary calling header

#include "verilated.h"

#include "VPCsrc_MUX___024root.h"

VL_ATTR_COLD void VPCsrc_MUX___024root___eval_initial(VPCsrc_MUX___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root___eval_initial\n"); );
}

void VPCsrc_MUX___024root___combo__TOP__0(VPCsrc_MUX___024root* vlSelf);

VL_ATTR_COLD void VPCsrc_MUX___024root___eval_settle(VPCsrc_MUX___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root___eval_settle\n"); );
    // Body
    VPCsrc_MUX___024root___combo__TOP__0(vlSelf);
}

VL_ATTR_COLD void VPCsrc_MUX___024root___final(VPCsrc_MUX___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root___final\n"); );
}

VL_ATTR_COLD void VPCsrc_MUX___024root___ctor_var_reset(VPCsrc_MUX___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->PCsrc = VL_RAND_RESET_I(1);
    vlSelf->branch_PC = VL_RAND_RESET_I(32);
    vlSelf->inc_PC = VL_RAND_RESET_I(32);
    vlSelf->next_PC = VL_RAND_RESET_I(32);
}
