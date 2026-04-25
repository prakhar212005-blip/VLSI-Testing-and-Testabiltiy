# VTT – VLSI Testing & Testability
**Manipal Institute of Technology | Department of Electronics & Communication Engineering**  
**B.Tech ECE | Academic Year 2024–25**

---

## 📋 Assignment Overview

This repository contains Verilog HDL simulations for IA-4 (Internal Assessment 4) covering **VLSI Testing and Testability (VTT)** concepts including fault modeling, fault simulation, LFSR sequence generation, and scan-based Design-for-Testability (DFT).

All simulations are designed to run on **[EDA Playground](https://www.edaplayground.com)** using **Icarus Verilog 10.3** with **EPWave** for waveform viewing.

---

## 📁 Repository Structure

```
VTT_IA4_Project/
├── NAND_NOR_Fault/
│   ├── design.sv        ← 3-input NAND and NOR gate modules
│   ├── testbench.sv     ← SA0/SA1 fault injection on all inputs & output
│   └── README.md
│
├── CMOS_Inverter_Fault/
│   ├── design.sv        ← Good inverter, open pMOS drain, grounded nMOS gate
│   ├── testbench.sv     ← Compares good vs faulty outputs
│   └── README.md
│
├── Serial_Fault_Sim/
│   ├── design.sv        ← DUT: Y = (A & B) | C  (gate-level)
│   ├── testbench.sv     ← Serial fault injection using force/release
│   └── README.md
│
├── LFSR/
│   ├── design.sv        ← 3-bit LFSR: P(x) = 1 + x² + x³
│   ├── testbench.sv     ← Clock generation, reset, 9-cycle observation
│   └── README.md
│
├── Scan_Chain/
│   ├── design.sv        ← scan_ff module + scan_register_4bit
│   ├── testbench.sv     ← Normal/Scan mode testing
│   └── README.md
│
└── README.md            ← This file
```

---

## 🚀 How to Run Simulations (EDA Playground)

1. Go to [https://www.edaplayground.com](https://www.edaplayground.com) and sign in
2. For each question folder:
   - Paste `design.sv` content into the **Design** tab
   - Paste `testbench.sv` content into the **Testbench** tab
3. In **Tools & Simulators**, select:
   - **Language**: SystemVerilog/Verilog
   - **Simulator**: Icarus Verilog 10.3
4. Check **"Open EPWave after run"** to view waveforms
5. Click **Run**

---

## 📝 Question Summary

### 3-input NAND & NOR Gate Fault Simulation
Simulates stuck-at-0 (SA0) and stuck-at-1 (SA1) faults on all inputs and output of 3-input NAND and NOR gates. Verification tables confirm fault detection.

**Key concepts**: SA0/SA1 fault model, exhaustive testing, truth table verification

### CMOS Inverter Transistor-Level Faults
Simulates (a) open pMOS drain fault and (b) grounded nMOS gate fault on a CMOS inverter. Shows how transistor-level defects affect circuit logic levels.

**Key concepts**: CMOS inverter, pMOS/nMOS switching, transistor-level fault modeling

### Serial Fault Simulation Procedure
Implements serial fault simulation for `Y = (A & B) | C`. Uses Verilog `force`/`release` to inject 6 faults serially (one at a time), applying all 8 test vectors per fault.

**Key concepts**: Serial fault simulation, golden model comparison, fault coverage

### LFSR Sequence Generation
Implements a 3-bit Fibonacci LFSR for P(x) = 1 + x² + x³. Generates the maximal-length 7-state sequence: `001 → 010 → 101 → 011 → 111 → 110 → 100 → (repeat)`.

**Key concepts**: LFSR, feedback polynomial, maximal-length sequence, BIST

### 4-bit Scan Chain (Open-Ended)
Designs a 4-bit scan chain using scan flip-flops supporting both parallel (normal) and serial (scan) modes. Demonstrates DFT concepts of controllability and observability.

**Key concepts**: DFT, scan flip-flop, scan-in/scan-out, parallel vs serial data path

---

## 🔧 Tools Used
- **EDA Playground** – Online simulation platform
- **Icarus Verilog 10.3** – Open-source Verilog simulator
- **EPWave** – Waveform viewer
- **CircuitLab** – Schematic drawing

---

## 📚 References
1. Zainalabedin Navabi, *Digital System Test and Testable Design*, Springer, 2011
2. Suman Lata Tripathi et al., *Advanced VLSI Design and Testability Issues*, CRC Press, 2020
3. Svetlana N. Yanushkevich & Vlad P. Shmerko, *Introduction to Logic Design*, CRC Press, 2019
