// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VPCsrc_MUX__Syms.h"


VL_ATTR_COLD void VPCsrc_MUX___024root__trace_init_sub__TOP__0(VPCsrc_MUX___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+1,"PCsrc", false,-1);
    tracep->declBus(c+2,"branch_PC", false,-1, 31,0);
    tracep->declBus(c+3,"inc_PC", false,-1, 31,0);
    tracep->declBus(c+4,"next_PC", false,-1, 31,0);
    tracep->pushNamePrefix("PCsrc_MUX ");
    tracep->declBit(c+1,"PCsrc", false,-1);
    tracep->declBus(c+2,"branch_PC", false,-1, 31,0);
    tracep->declBus(c+3,"inc_PC", false,-1, 31,0);
    tracep->declBus(c+4,"next_PC", false,-1, 31,0);
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void VPCsrc_MUX___024root__trace_init_top(VPCsrc_MUX___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root__trace_init_top\n"); );
    // Body
    VPCsrc_MUX___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void VPCsrc_MUX___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VPCsrc_MUX___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VPCsrc_MUX___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void VPCsrc_MUX___024root__trace_register(VPCsrc_MUX___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&VPCsrc_MUX___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&VPCsrc_MUX___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&VPCsrc_MUX___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void VPCsrc_MUX___024root__trace_full_sub_0(VPCsrc_MUX___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void VPCsrc_MUX___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root__trace_full_top_0\n"); );
    // Init
    VPCsrc_MUX___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VPCsrc_MUX___024root*>(voidSelf);
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    VPCsrc_MUX___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void VPCsrc_MUX___024root__trace_full_sub_0(VPCsrc_MUX___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VPCsrc_MUX___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullBit(oldp+1,(vlSelf->PCsrc));
    bufp->fullIData(oldp+2,(vlSelf->branch_PC),32);
    bufp->fullIData(oldp+3,(vlSelf->inc_PC),32);
    bufp->fullIData(oldp+4,(vlSelf->next_PC),32);
}
