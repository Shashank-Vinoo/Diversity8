// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VRegFile__Syms.h"


VL_ATTR_COLD void VRegFile___024root__trace_init_sub__TOP__0(VRegFile___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+33,"clk", false,-1);
    tracep->declBit(c+34,"WE3", false,-1);
    tracep->declBus(c+35,"AD1", false,-1, 4,0);
    tracep->declBus(c+36,"AD2", false,-1, 4,0);
    tracep->declBus(c+37,"AD3", false,-1, 4,0);
    tracep->declBus(c+38,"WD3", false,-1, 31,0);
    tracep->declBus(c+39,"RD1", false,-1, 31,0);
    tracep->declBus(c+40,"RD2", false,-1, 31,0);
    tracep->declBus(c+41,"a0", false,-1, 31,0);
    tracep->pushNamePrefix("RegFile ");
    tracep->declBit(c+33,"clk", false,-1);
    tracep->declBit(c+34,"WE3", false,-1);
    tracep->declBus(c+35,"AD1", false,-1, 4,0);
    tracep->declBus(c+36,"AD2", false,-1, 4,0);
    tracep->declBus(c+37,"AD3", false,-1, 4,0);
    tracep->declBus(c+38,"WD3", false,-1, 31,0);
    tracep->declBus(c+39,"RD1", false,-1, 31,0);
    tracep->declBus(c+40,"RD2", false,-1, 31,0);
    tracep->declBus(c+41,"a0", false,-1, 31,0);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+1+i*1,"registers", true,(i+0), 31,0);
    }
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void VRegFile___024root__trace_init_top(VRegFile___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root__trace_init_top\n"); );
    // Body
    VRegFile___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void VRegFile___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VRegFile___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VRegFile___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void VRegFile___024root__trace_register(VRegFile___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&VRegFile___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&VRegFile___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&VRegFile___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void VRegFile___024root__trace_full_sub_0(VRegFile___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void VRegFile___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root__trace_full_top_0\n"); );
    // Init
    VRegFile___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VRegFile___024root*>(voidSelf);
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    VRegFile___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void VRegFile___024root__trace_full_sub_0(VRegFile___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VRegFile___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+1,(vlSelf->RegFile__DOT__registers[0]),32);
    bufp->fullIData(oldp+2,(vlSelf->RegFile__DOT__registers[1]),32);
    bufp->fullIData(oldp+3,(vlSelf->RegFile__DOT__registers[2]),32);
    bufp->fullIData(oldp+4,(vlSelf->RegFile__DOT__registers[3]),32);
    bufp->fullIData(oldp+5,(vlSelf->RegFile__DOT__registers[4]),32);
    bufp->fullIData(oldp+6,(vlSelf->RegFile__DOT__registers[5]),32);
    bufp->fullIData(oldp+7,(vlSelf->RegFile__DOT__registers[6]),32);
    bufp->fullIData(oldp+8,(vlSelf->RegFile__DOT__registers[7]),32);
    bufp->fullIData(oldp+9,(vlSelf->RegFile__DOT__registers[8]),32);
    bufp->fullIData(oldp+10,(vlSelf->RegFile__DOT__registers[9]),32);
    bufp->fullIData(oldp+11,(vlSelf->RegFile__DOT__registers[10]),32);
    bufp->fullIData(oldp+12,(vlSelf->RegFile__DOT__registers[11]),32);
    bufp->fullIData(oldp+13,(vlSelf->RegFile__DOT__registers[12]),32);
    bufp->fullIData(oldp+14,(vlSelf->RegFile__DOT__registers[13]),32);
    bufp->fullIData(oldp+15,(vlSelf->RegFile__DOT__registers[14]),32);
    bufp->fullIData(oldp+16,(vlSelf->RegFile__DOT__registers[15]),32);
    bufp->fullIData(oldp+17,(vlSelf->RegFile__DOT__registers[16]),32);
    bufp->fullIData(oldp+18,(vlSelf->RegFile__DOT__registers[17]),32);
    bufp->fullIData(oldp+19,(vlSelf->RegFile__DOT__registers[18]),32);
    bufp->fullIData(oldp+20,(vlSelf->RegFile__DOT__registers[19]),32);
    bufp->fullIData(oldp+21,(vlSelf->RegFile__DOT__registers[20]),32);
    bufp->fullIData(oldp+22,(vlSelf->RegFile__DOT__registers[21]),32);
    bufp->fullIData(oldp+23,(vlSelf->RegFile__DOT__registers[22]),32);
    bufp->fullIData(oldp+24,(vlSelf->RegFile__DOT__registers[23]),32);
    bufp->fullIData(oldp+25,(vlSelf->RegFile__DOT__registers[24]),32);
    bufp->fullIData(oldp+26,(vlSelf->RegFile__DOT__registers[25]),32);
    bufp->fullIData(oldp+27,(vlSelf->RegFile__DOT__registers[26]),32);
    bufp->fullIData(oldp+28,(vlSelf->RegFile__DOT__registers[27]),32);
    bufp->fullIData(oldp+29,(vlSelf->RegFile__DOT__registers[28]),32);
    bufp->fullIData(oldp+30,(vlSelf->RegFile__DOT__registers[29]),32);
    bufp->fullIData(oldp+31,(vlSelf->RegFile__DOT__registers[30]),32);
    bufp->fullIData(oldp+32,(vlSelf->RegFile__DOT__registers[31]),32);
    bufp->fullBit(oldp+33,(vlSelf->clk));
    bufp->fullBit(oldp+34,(vlSelf->WE3));
    bufp->fullCData(oldp+35,(vlSelf->AD1),5);
    bufp->fullCData(oldp+36,(vlSelf->AD2),5);
    bufp->fullCData(oldp+37,(vlSelf->AD3),5);
    bufp->fullIData(oldp+38,(vlSelf->WD3),32);
    bufp->fullIData(oldp+39,(vlSelf->RD1),32);
    bufp->fullIData(oldp+40,(vlSelf->RD2),32);
    bufp->fullIData(oldp+41,(vlSelf->a0),32);
}
