// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VALU_Src_Mux.h"
#include "VALU_Src_Mux__Syms.h"

//============================================================
// Constructors

VALU_Src_Mux::VALU_Src_Mux(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VALU_Src_Mux__Syms(contextp(), _vcname__, this)}
    , ALUsrc{vlSymsp->TOP.ALUsrc}
    , regOp2{vlSymsp->TOP.regOp2}
    , ImmOp{vlSymsp->TOP.ImmOp}
    , ALUOp2{vlSymsp->TOP.ALUOp2}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VALU_Src_Mux::VALU_Src_Mux(const char* _vcname__)
    : VALU_Src_Mux(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VALU_Src_Mux::~VALU_Src_Mux() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void VALU_Src_Mux___024root___eval_initial(VALU_Src_Mux___024root* vlSelf);
void VALU_Src_Mux___024root___eval_settle(VALU_Src_Mux___024root* vlSelf);
void VALU_Src_Mux___024root___eval(VALU_Src_Mux___024root* vlSelf);
#ifdef VL_DEBUG
void VALU_Src_Mux___024root___eval_debug_assertions(VALU_Src_Mux___024root* vlSelf);
#endif  // VL_DEBUG
void VALU_Src_Mux___024root___final(VALU_Src_Mux___024root* vlSelf);

static void _eval_initial_loop(VALU_Src_Mux__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    VALU_Src_Mux___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        VALU_Src_Mux___024root___eval_settle(&(vlSymsp->TOP));
        VALU_Src_Mux___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void VALU_Src_Mux::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VALU_Src_Mux::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VALU_Src_Mux___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        VALU_Src_Mux___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

const char* VALU_Src_Mux::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void VALU_Src_Mux::final() {
    VALU_Src_Mux___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VALU_Src_Mux::hierName() const { return vlSymsp->name(); }
const char* VALU_Src_Mux::modelName() const { return "VALU_Src_Mux"; }
unsigned VALU_Src_Mux::threads() const { return 1; }
