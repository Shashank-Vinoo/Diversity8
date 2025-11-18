#!/bin/bash

# ============================================================
# Usage:
#   ./run_tb.sh <top_module_name> <testbench_cpp_file>
#
# Example:
#   ./run_tb.sh PC_REG PC_REG_tb.cpp
# ============================================================

set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <top_module_name> <testbench_cpp>"
    exit 1
fi

TOP=$1              # e.g. PC_REG
TB_CPP=$2           # e.g. PC_REG_tb.cpp
SV_FILE="${TOP}.sv" # e.g. PC_REG.sv
MK_FILE="V${TOP}.mk"
EXE_FILE="V${TOP}"
DUT="V${TOP}"       # Verilated DUT class name

GTEST_PREFIX=$(brew --prefix googletest 2>/dev/null || echo "")
if [ -d "${GTEST_PREFIX}/include" ]; then
  GTEST_CFLAGS="-I${GTEST_PREFIX}/include"
  GTEST_LDFLAGS="-L${GTEST_PREFIX}/lib"
else
  echo "[WARN] googletest not found. Install with: brew install googletest"
fi

# ============================================================
# 1. Generate NON-templated base_testbench.h
# ============================================================

cat > base_testbench.h << EOF
#pragma once

#include <memory>
#include <string>
#include <cstdlib>

#include "verilated.h"
#include "verilated_vcd_c.h"
#include "gtest/gtest.h"
#include "${DUT}.h"

extern unsigned int ticks;

class BaseTestbench : public ::testing::Test
{
public:
    void SetUp() override
    {
        top = std::make_unique<${DUT}>();

#ifndef __APPLE__
        tfp = std::make_unique<VerilatedVcdC>();
        Verilated::traceEverOn(true);
        top->trace(tfp.get(), 99);
        tfp->open("waveform.vcd");
#endif

        initializeInputs();
    }

    void TearDown() override
    {
        top->final();
#ifndef __APPLE__
        tfp->close();
#endif
    }

    virtual void initializeInputs() = 0;

protected:
    std::unique_ptr<${DUT}> top;

#ifndef __APPLE__
    std::unique_ptr<VerilatedVcdC> tfp;
#endif
};
EOF

# ============================================================
# 2. Generate testbench.h (optional helper)
# ============================================================

cat > testbench.h << EOF
#pragma once
#include "base_testbench.h"

class Testbench : public BaseTestbench
{
public:
    void tick()
    {
        top->clk = 0; top->eval();
        top->clk = 1; top->eval();
        ticks++;
    }
};
EOF

# ============================================================
# 3. Build with Verilator
# ============================================================

echo "[INFO] Cleaning old obj_dir..."
rm -rf obj_dir

echo "[INFO] Running Verilator on ${SV_FILE} ..."
verilator -Wall --cc "${SV_FILE}" \
  --exe "${TB_CPP}" \
  -I. \
  --trace \
  --CFLAGS "-std=c++17 ${GTEST_CFLAGS}" \
  -LDFLAGS "${GTEST_LDFLAGS} -lgtest -lgtest_main -pthread"


echo "[INFO] Building simulation..."
make -j -C obj_dir -f "${MK_FILE}" "${EXE_FILE}"

echo "[INFO] Running tests..."
./obj_dir/"${EXE_FILE}"

if [ -f waveform.vcd ]; then
    echo "[INFO] Opening waveform..."
    gtkwave waveform.vcd &
fi
