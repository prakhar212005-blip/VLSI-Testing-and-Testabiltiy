# 3-bit LFSR Sequence Generation

## Aim
Implement and simulate a 3-bit Linear Feedback Shift Register (LFSR) using Verilog for polynomial P(x) = 1 + x² + x³ and observe the generated maximal-length sequence.

## Files
- `design.sv` – LFSR module with XOR feedback from bits [2] and [1]
- `testbench.sv` – Clock generation, reset pulse, and 9-cycle observation

## How to Run on EDA Playground
1. Paste `design.sv` into **Design** panel
2. Paste `testbench.sv` into **Testbench** panel
3. Select **Icarus Verilog 10.3**; check **Open EPWave after run**
4. Click **Run**

## LFSR Theory
- **Polynomial**: P(x) = 1 + x² + x³
- **Feedback bit**: f = q[2] ⊕ q[1]  (taps at x³ and x²)
- **Shift rule**: q_next = { q[1], q[0], f }
- **Maximal length**: 2³ - 1 = **7 states** (all non-zero 3-bit values)

## Expected State Table
| Clock Cycle | q[2] q[1] q[0] | SO (q[0]) |
|-------------|---------------|-----------|
|      0      |    0  0  1    |     1     |
|      1      |    0  1  0    |     0     |
|      2      |    1  0  1    |     1     |
|      3      |    0  1  1    |     1     |
|      4      |    1  1  1    |     1     |
|      5      |    1  1  0    |     0     |
|      6      |    1  0  0    |     0     |
|      7      |    0  0  1    |     1     | ← Repeats (period = 7)

## Serial Output Sequence: 1, 0, 1, 1, 1, 0, 0 (then repeats)

## Key Properties
- The LFSR cycles through all 7 non-zero 3-bit states before repeating
- The all-zero state (000) is a lock-up state and is avoided by the non-zero seed
- Applications: BIST (Built-In Self-Test), pseudo-random number generation, scrambling in communications
