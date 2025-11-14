// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VRegFile.h for the primary calling header

#include "verilated.h"

#include "VRegFile___024root.h"

VL_ATTR_COLD void VRegFile___024root___settle__TOP__0(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___settle__TOP__0\n"); );
    // Body
    vlSelf->a0 = vlSelf->RegFile__DOT__registers[0xaU];
    vlSelf->RD1 = vlSelf->RegFile__DOT__registers[vlSelf->AD1];
    vlSelf->RD2 = vlSelf->RegFile__DOT__registers[vlSelf->AD2];
}

VL_ATTR_COLD void VRegFile___024root___eval_initial(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___eval_initial\n"); );
    // Body
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

VL_ATTR_COLD void VRegFile___024root___eval_settle(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___eval_settle\n"); );
    // Body
    VRegFile___024root___settle__TOP__0(vlSelf);
}

VL_ATTR_COLD void VRegFile___024root___final(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___final\n"); );
}

VL_ATTR_COLD void VRegFile___024root___ctor_var_reset(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->WE3 = VL_RAND_RESET_I(1);
    vlSelf->AD1 = VL_RAND_RESET_I(5);
    vlSelf->AD2 = VL_RAND_RESET_I(5);
    vlSelf->AD3 = VL_RAND_RESET_I(5);
    vlSelf->WD3 = VL_RAND_RESET_I(32);
    vlSelf->RD1 = VL_RAND_RESET_I(32);
    vlSelf->RD2 = VL_RAND_RESET_I(32);
    vlSelf->a0 = VL_RAND_RESET_I(32);
    for (int __Vi0=0; __Vi0<32; ++__Vi0) {
        vlSelf->RegFile__DOT__registers[__Vi0] = VL_RAND_RESET_I(32);
    }
    for (int __Vi0=0; __Vi0<2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = VL_RAND_RESET_I(1);
    }
}
