#!/usr/bin/env bash

# Compiles with Icarus Verilog and opens GTKWave

SCRIPT_DIR=$(dirname "$(realpath "$0")")
RTL_DIR="${SCRIPT_DIR}/../rtl"

TB_FILE="${SCRIPT_DIR}/tests/top_tb.sv"
HEX_FILE="${RTL_DIR}/program.hex"
OUT="top_sim"

echo "=== Compiling RISC-V Design ==="
iverilog -g2012 -Wall -o "${OUT}" \
    "${TB_FILE}" \
    "${RTL_DIR}/top.sv" \
    "${RTL_DIR}/PC_REG.sv" \
    "${RTL_DIR}/PCsrc_MUX.sv" \
    "${RTL_DIR}/Branch_PC_Adder.sv" \
    "${RTL_DIR}/InstrMem.sv" \
    "${RTL_DIR}/ImmGen.sv" \
    "${RTL_DIR}/ControlUnit.sv" \
    "${RTL_DIR}/ALU_Src_Mux.sv" \
    "${RTL_DIR}/ALU.sv" \
    "${RTL_DIR}/RegFile.sv" \
    "${RTL_DIR}/Data.sv" \
    "${RTL_DIR}/Data_mux.sv"

echo "=== Running Simulation ==="
vvp "${OUT}" +IMEM="${HEX_FILE}"

echo "=== Opening GTKWave ==="
if [ -f "top_tb.vcd" ]; then
    gtkwave top_tb.vcd --start 0 --end 15ms
else
    echo "ERROR: VCD file not found!"
fi

echo "=== Done ==="