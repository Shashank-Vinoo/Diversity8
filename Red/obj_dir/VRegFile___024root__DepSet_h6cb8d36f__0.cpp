// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VRegFile.h for the primary calling header

#include "verilated.h"

#include "VRegFile___024root.h"

VL_INLINE_OPT void VRegFile___024root___sequent__TOP__0(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___sequent__TOP__0\n"); );
    // Init
    CData/*4:0*/ __Vdlyvdim0__RegFile__DOT__registers__v0;
    IData/*31:0*/ __Vdlyvval__RegFile__DOT__registers__v0;
    CData/*0:0*/ __Vdlyvset__RegFile__DOT__registers__v0;
    // Body
    __Vdlyvset__RegFile__DOT__registers__v0 = 0U;
    if (((IData)(vlSelf->WE3) & (0U != (IData)(vlSelf->AD3)))) {
        __Vdlyvval__RegFile__DOT__registers__v0 = vlSelf->WD3;
        __Vdlyvset__RegFile__DOT__registers__v0 = 1U;
        __Vdlyvdim0__RegFile__DOT__registers__v0 = vlSelf->AD3;
    }
    if (__Vdlyvset__RegFile__DOT__registers__v0) {
        vlSelf->RegFile__DOT__registers[__Vdlyvdim0__RegFile__DOT__registers__v0] 
            = __Vdlyvval__RegFile__DOT__registers__v0;
    }
    vlSelf->a0 = vlSelf->RegFile__DOT__registers[0xaU];
}

VL_INLINE_OPT void VRegFile___024root___combo__TOP__0(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___combo__TOP__0\n"); );
    // Body
    vlSelf->RD1 = vlSelf->RegFile__DOT__registers[vlSelf->AD1];
    vlSelf->RD2 = vlSelf->RegFile__DOT__registers[vlSelf->AD2];
}

void VRegFile___024root___eval(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___eval\n"); );
    // Body
    if (((IData)(vlSelf->clk) & (~ (IData)(vlSelf->__Vclklast__TOP__clk)))) {
        VRegFile___024root___sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
    VRegFile___024root___combo__TOP__0(vlSelf);
    // Final
    vlSelf->__Vclklast__TOP__clk = vlSelf->clk;
}

#ifdef VL_DEBUG
void VRegFile___024root___eval_debug_assertions(VRegFile___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->WE3 & 0xfeU))) {
        Verilated::overWidthError("WE3");}
    if (VL_UNLIKELY((vlSelf->AD1 & 0xe0U))) {
        Verilated::overWidthError("AD1");}
    if (VL_UNLIKELY((vlSelf->AD2 & 0xe0U))) {
        Verilated::overWidthError("AD2");}
    if (VL_UNLIKELY((vlSelf->AD3 & 0xe0U))) {
        Verilated::overWidthError("AD3");}
}
#endif  // VL_DEBUG
