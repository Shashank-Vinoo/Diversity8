#!/usr/bin/env bash

# Compiles with Icarus Verilog and opens GTKWave

SCRIPT_DIR=$(dirname "$(realpath "$0")")
RTL_DIR="${SCRIPT_DIR}/../rtl"

TB_FILE="${SCRIPT_DIR}/tests/top_tb.sv"
HEX_FILE="${RTL_DIR}/program.hex"
OUT="top_sim"

rm -f "${OUT}" top_tb.vcd

echo "=== Compiling RISC-V Design ==="
iverilog -g2012 -Wall -o "${OUT}" \
    "${TB_FILE}" \
    "${RTL_DIR}/top.sv" \
    "${RTL_DIR}/pc_reg.sv" \
    "${RTL_DIR}/pc_src_mux.sv" \
    "${RTL_DIR}/branch_pc_adder.sv" \
    "${RTL_DIR}/instr_mem.sv" \
    "${RTL_DIR}/imm_gen.sv" \
    "${RTL_DIR}/control_unit.sv" \
    "${RTL_DIR}/alu_src_mux.sv" \
    "${RTL_DIR}/alu.sv" \
    "${RTL_DIR}/reg_file.sv" \
    "${RTL_DIR}/data_mem.sv" \
    "${RTL_DIR}/data_mux.sv" \
    "${RTL_DIR}/pipe_fetch.sv" \
    "${RTL_DIR}/pipe_decode.sv" \
    "${RTL_DIR}/pipe_mem.sv" \
    "${RTL_DIR}/pipe_write.sv" \
    "${RTL_DIR}/hazard_unit.sv" \
    "${RTL_DIR}/control_hazard_unit.sv" \
    "${RTL_DIR}/data_hazard_unit.sv" \
    "${RTL_DIR}/alu_hazard_mux.sv" 


echo "=== Running Simulation ==="
vvp "${OUT}" +IMEM="${HEX_FILE}"

echo "=== Opening GTKWave ==="
if [ -f "top_tb.vcd" ]; then
    gtkwave top_tb.vcd --start 0 --end 15ms
else
    echo "ERROR: VCD file not found!"
fi

echo "=== Done ==="
