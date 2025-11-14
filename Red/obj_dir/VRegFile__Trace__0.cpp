// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VRegFile__Syms.h"


void VRegFile___024root__trace_chg_sub_0(VRegFile___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void VRegFile___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root__trace_chg_top_0\n"); );
    // Init
    VRegFile___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VRegFile___024root*>(voidSelf);
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    VRegFile___024root__trace_chg_sub_0((&vlSymsp->TOP), bufp);
}

void VRegFile___024root__trace_chg_sub_0(VRegFile___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root__trace_chg_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgIData(oldp+0,(vlSelf->RegFile__DOT__registers[0]),32);
        bufp->chgIData(oldp+1,(vlSelf->RegFile__DOT__registers[1]),32);
        bufp->chgIData(oldp+2,(vlSelf->RegFile__DOT__registers[2]),32);
        bufp->chgIData(oldp+3,(vlSelf->RegFile__DOT__registers[3]),32);
        bufp->chgIData(oldp+4,(vlSelf->RegFile__DOT__registers[4]),32);
        bufp->chgIData(oldp+5,(vlSelf->RegFile__DOT__registers[5]),32);
        bufp->chgIData(oldp+6,(vlSelf->RegFile__DOT__registers[6]),32);
        bufp->chgIData(oldp+7,(vlSelf->RegFile__DOT__registers[7]),32);
        bufp->chgIData(oldp+8,(vlSelf->RegFile__DOT__registers[8]),32);
        bufp->chgIData(oldp+9,(vlSelf->RegFile__DOT__registers[9]),32);
        bufp->chgIData(oldp+10,(vlSelf->RegFile__DOT__registers[10]),32);
        bufp->chgIData(oldp+11,(vlSelf->RegFile__DOT__registers[11]),32);
        bufp->chgIData(oldp+12,(vlSelf->RegFile__DOT__registers[12]),32);
        bufp->chgIData(oldp+13,(vlSelf->RegFile__DOT__registers[13]),32);
        bufp->chgIData(oldp+14,(vlSelf->RegFile__DOT__registers[14]),32);
        bufp->chgIData(oldp+15,(vlSelf->RegFile__DOT__registers[15]),32);
        bufp->chgIData(oldp+16,(vlSelf->RegFile__DOT__registers[16]),32);
        bufp->chgIData(oldp+17,(vlSelf->RegFile__DOT__registers[17]),32);
        bufp->chgIData(oldp+18,(vlSelf->RegFile__DOT__registers[18]),32);
        bufp->chgIData(oldp+19,(vlSelf->RegFile__DOT__registers[19]),32);
        bufp->chgIData(oldp+20,(vlSelf->RegFile__DOT__registers[20]),32);
        bufp->chgIData(oldp+21,(vlSelf->RegFile__DOT__registers[21]),32);
        bufp->chgIData(oldp+22,(vlSelf->RegFile__DOT__registers[22]),32);
        bufp->chgIData(oldp+23,(vlSelf->RegFile__DOT__registers[23]),32);
        bufp->chgIData(oldp+24,(vlSelf->RegFile__DOT__registers[24]),32);
        bufp->chgIData(oldp+25,(vlSelf->RegFile__DOT__registers[25]),32);
        bufp->chgIData(oldp+26,(vlSelf->RegFile__DOT__registers[26]),32);
        bufp->chgIData(oldp+27,(vlSelf->RegFile__DOT__registers[27]),32);
        bufp->chgIData(oldp+28,(vlSelf->RegFile__DOT__registers[28]),32);
        bufp->chgIData(oldp+29,(vlSelf->RegFile__DOT__registers[29]),32);
        bufp->chgIData(oldp+30,(vlSelf->RegFile__DOT__registers[30]),32);
        bufp->chgIData(oldp+31,(vlSelf->RegFile__DOT__registers[31]),32);
    }
    bufp->chgBit(oldp+32,(vlSelf->clk));
    bufp->chgBit(oldp+33,(vlSelf->WE3));
    bufp->chgCData(oldp+34,(vlSelf->AD1),5);
    bufp->chgCData(oldp+35,(vlSelf->AD2),5);
    bufp->chgCData(oldp+36,(vlSelf->AD3),5);
    bufp->chgIData(oldp+37,(vlSelf->WD3),32);
    bufp->chgIData(oldp+38,(vlSelf->RD1),32);
    bufp->chgIData(oldp+39,(vlSelf->RD2),32);
    bufp->chgIData(oldp+40,(vlSelf->a0),32);
}

void VRegFile___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root__trace_cleanup\n"); );
    // Init
    VRegFile___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VRegFile___024root*>(voidSelf);
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
