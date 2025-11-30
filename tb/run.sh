#!/bin/bash

# This script runs the testbench
# Usage: ./doit.sh <file1.cpp> <file2.cpp>

# Constants
SCRIPT_DIR=$(dirname "$(realpath "$0")")
TEST_FOLDER=$(realpath "$SCRIPT_DIR/tests")
RTL_FOLDER=$(realpath "$SCRIPT_DIR/../rtl")

# Colors (fall back to no color if tput not available)
if command -v tput >/dev/null 2>&1; then
    GREEN=$(tput setaf 2)
    RED=$(tput setaf 1)
    RESET=$(tput sgr0)
else
    GREEN=""
    RED=""
    RESET=""
fi

# Variables
passes=0
fails=0

# Handle terminal arguments
if [[ $# -eq 0 ]]; then
    # If no arguments provided, run all tests
    # Use array-safe expansion
    mapfile -t files < <(printf '%s\n' "${TEST_FOLDER}"/*.cpp)
else
    # If arguments provided, use them as input files
    files=("$@")
fi

# Cleanup
rm -rf obj_dir

cd "$SCRIPT_DIR"

if [[ -z "${GTEST_INCLUDE:-}" || -z "${GTEST_LIB:-}" ]]; then
    OS_TYPE=$(uname -s 2>/dev/null || echo unknown)

    # Try Homebrew on macOS if brew exists
    if command -v brew >/dev/null 2>&1; then
        GTEST_BASE=$(brew --prefix googletest 2>/dev/null || true)
        if [[ -n "$GTEST_BASE" ]]; then
            GTEST_INCLUDE="$GTEST_BASE/include"
            GTEST_LIB="$GTEST_BASE/lib"
        fi
    fi

    # If still not found, try common Linux/WSL locations
    if [[ -z "${GTEST_INCLUDE:-}" || -z "${GTEST_LIB:-}" ]]; then
        # Typical Debian/Ubuntu layout
        if [[ -d /usr/src/googletest/googletest/include ]]; then
            GTEST_INCLUDE="/usr/src/googletest/googletest/include"
        elif [[ -d /usr/include/gtest ]]; then
            GTEST_INCLUDE="/usr/include"
        fi

        if [[ -d /usr/lib/gtest ]]; then
            GTEST_LIB="/usr/lib/gtest"
        elif [[ -d /usr/lib ]]; then
            GTEST_LIB="/usr/lib"
        elif [[ -d /usr/lib64 ]]; then
            GTEST_LIB="/usr/lib64"
        fi
    fi
fi

# Final check
if [[ -z "${GTEST_INCLUDE:-}" || -z "${GTEST_LIB:-}" ]]; then
    echo "${RED}Error: GoogleTest not found.${RESET}"
    echo "Set GTEST_INCLUDE and GTEST_LIB, e.g.:"
    echo "  export GTEST_INCLUDE=/usr/include"
    echo "  export GTEST_LIB=/usr/lib"
    echo "or install via Homebrew (macOS) or apt (WSL/Linux)."
    exit 1
fi

# Iterate through files
for file in "${files[@]}"; do
    name=$(basename "$file" _tb.cpp | cut -f1 -d\-)
    
    # If verify.cpp -> we are testing the top module
    if [[ "$name" == "verify.cpp" ]]; then
        name="top"
    fi

    sv_file="${RTL_FOLDER}/${name}.sv"
    if [[ ! -f "${sv_file}" ]]; then
        echo "${RED}Error: RTL file not found for base name '${name}'.${RESET}"
        exit 1
    fi

    verilator   -Wall --trace \
                -cc "${sv_file}" \
                --exe "${file}" \
                -y "${RTL_FOLDER}" \
                --prefix "Vdut" \
                -o Vdut \
                -CFLAGS "-std=c++17 -isystem ${GTEST_INCLUDE}" \
                -LDFLAGS "-L${GTEST_LIB} -lgtest -lgtest_main -lpthread"
                
if [[ $? -ne 0 ]]; then
    echo "${RED}Error: Verilator failed to compile ${sv_file}.${RESET}"
    exit 1
fi

    # Build C++ project with automatically generated Makefile
    make -j -C obj_dir/ -f Vdut.mk

# Abort if make failed
if [[ $? -ne 0 ]]; then
    echo "${RED}Error: make failed to build obj_dir/Vdut.${RESET}"
    exit 1
fi

    # Build C++ project with automatically generated Makefile
    make -j -C obj_dir/ -f Vdut.mk
    
    # Run executable simulation file
    ./obj_dir/Vdut
    status=$?
    
    # Check if the test succeeded or not
    if [[ $status -eq 0 ]]; then
        ((passes++))
    else
        ((fails++))
    fi
    
done

# Exit as a pass or fail (for CI purposes)
if [[ $fails -eq 0 ]]; then
    echo "${GREEN}Success! All ${passes} test(s) passed!${RESET}"
    exit 0
else
    total=$((passes + fails))
    echo "${RED}Failure! Only ${passes} test(s) passed out of ${total}.${RESET}"
    exit 1
fi
