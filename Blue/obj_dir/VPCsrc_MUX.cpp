// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VPCsrc_MUX.h"
#include "VPCsrc_MUX__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

VPCsrc_MUX::VPCsrc_MUX(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VPCsrc_MUX__Syms(contextp(), _vcname__, this)}
    , PCsrc{vlSymsp->TOP.PCsrc}
    , branch_PC{vlSymsp->TOP.branch_PC}
    , inc_PC{vlSymsp->TOP.inc_PC}
    , next_PC{vlSymsp->TOP.next_PC}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VPCsrc_MUX::VPCsrc_MUX(const char* _vcname__)
    : VPCsrc_MUX(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VPCsrc_MUX::~VPCsrc_MUX() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void VPCsrc_MUX___024root___eval_initial(VPCsrc_MUX___024root* vlSelf);
void VPCsrc_MUX___024root___eval_settle(VPCsrc_MUX___024root* vlSelf);
void VPCsrc_MUX___024root___eval(VPCsrc_MUX___024root* vlSelf);
#ifdef VL_DEBUG
void VPCsrc_MUX___024root___eval_debug_assertions(VPCsrc_MUX___024root* vlSelf);
#endif  // VL_DEBUG
void VPCsrc_MUX___024root___final(VPCsrc_MUX___024root* vlSelf);

static void _eval_initial_loop(VPCsrc_MUX__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    VPCsrc_MUX___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        VPCsrc_MUX___024root___eval_settle(&(vlSymsp->TOP));
        VPCsrc_MUX___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void VPCsrc_MUX::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VPCsrc_MUX::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VPCsrc_MUX___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        VPCsrc_MUX___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

const char* VPCsrc_MUX::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void VPCsrc_MUX::final() {
    VPCsrc_MUX___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VPCsrc_MUX::hierName() const { return vlSymsp->name(); }
const char* VPCsrc_MUX::modelName() const { return "VPCsrc_MUX"; }
unsigned VPCsrc_MUX::threads() const { return 1; }
std::unique_ptr<VerilatedTraceConfig> VPCsrc_MUX::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void VPCsrc_MUX___024root__trace_init_top(VPCsrc_MUX___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    VPCsrc_MUX___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VPCsrc_MUX___024root*>(voidSelf);
    VPCsrc_MUX__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->scopeEscape(' ');
    tracep->pushNamePrefix(std::string{vlSymsp->name()} + ' ');
    VPCsrc_MUX___024root__trace_init_top(vlSelf, tracep);
    tracep->popNamePrefix();
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void VPCsrc_MUX___024root__trace_register(VPCsrc_MUX___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void VPCsrc_MUX::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    VPCsrc_MUX___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
