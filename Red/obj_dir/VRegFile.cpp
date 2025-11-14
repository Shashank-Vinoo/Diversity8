// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VRegFile.h"
#include "VRegFile__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

VRegFile::VRegFile(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VRegFile__Syms(contextp(), _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , WE3{vlSymsp->TOP.WE3}
    , AD1{vlSymsp->TOP.AD1}
    , AD2{vlSymsp->TOP.AD2}
    , AD3{vlSymsp->TOP.AD3}
    , WD3{vlSymsp->TOP.WD3}
    , RD1{vlSymsp->TOP.RD1}
    , RD2{vlSymsp->TOP.RD2}
    , a0{vlSymsp->TOP.a0}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VRegFile::VRegFile(const char* _vcname__)
    : VRegFile(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VRegFile::~VRegFile() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void VRegFile___024root___eval_initial(VRegFile___024root* vlSelf);
void VRegFile___024root___eval_settle(VRegFile___024root* vlSelf);
void VRegFile___024root___eval(VRegFile___024root* vlSelf);
#ifdef VL_DEBUG
void VRegFile___024root___eval_debug_assertions(VRegFile___024root* vlSelf);
#endif  // VL_DEBUG
void VRegFile___024root___final(VRegFile___024root* vlSelf);

static void _eval_initial_loop(VRegFile__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    VRegFile___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        VRegFile___024root___eval_settle(&(vlSymsp->TOP));
        VRegFile___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void VRegFile::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VRegFile::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VRegFile___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        VRegFile___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

const char* VRegFile::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void VRegFile::final() {
    VRegFile___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VRegFile::hierName() const { return vlSymsp->name(); }
const char* VRegFile::modelName() const { return "VRegFile"; }
unsigned VRegFile::threads() const { return 1; }
std::unique_ptr<VerilatedTraceConfig> VRegFile::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void VRegFile___024root__trace_init_top(VRegFile___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    VRegFile___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VRegFile___024root*>(voidSelf);
    VRegFile__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->scopeEscape(' ');
    tracep->pushNamePrefix(std::string{vlSymsp->name()} + ' ');
    VRegFile___024root__trace_init_top(vlSelf, tracep);
    tracep->popNamePrefix();
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void VRegFile___024root__trace_register(VRegFile___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void VRegFile::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    VRegFile___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
