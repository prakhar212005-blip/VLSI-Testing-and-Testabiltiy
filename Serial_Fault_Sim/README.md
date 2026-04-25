# Q3 – Serial Fault Simulation Procedure

## Aim
Simulate a serial fault simulation procedure for a combinational circuit `Y = (A & B) | C` using Verilog and an EDA simulator. Detect stuck-at faults by injecting them one at a time and report detected/undetected faults.

## Files
- `design.sv` – DUT: gate-level implementation of `Y = (A & B) | C`
- `testbench.sv` – Serial fault injection with `force`/`release`, all 8 input vectors applied per fault

## How to Run on EDA Playground
1. Paste `design.sv` into **Design** panel
2. Paste `testbench.sv` into **Testbench** panel
3. Select **Icarus Verilog 10.3**; check **Open EPWave after run**
4. Click **Run** and check the log output

## Serial Fault Simulation Method
For each fault:
1. Force that net to the stuck value
2. Apply all 8 input combinations
3. Compare faulty vs. golden output
4. If any vector produces a difference → **Fault DETECTED**
5. Release the fault and move to the next one

## Faults Simulated
| # | Fault | Net | Value |
|---|-------|-----|-------|
| 1 | A_sa0 | Input A | stuck at 0 |
| 2 | A_sa1 | Input A | stuck at 1 |
| 3 | w1_sa0 | Internal AND output | stuck at 0 |
| 4 | w1_sa1 | Internal AND output | stuck at 1 |
| 5 | Y_sa0 | Output Y | stuck at 0 |
| 6 | Y_sa1 | Output Y | stuck at 1 |

## Verification Table: Y = (A & B) | C
| A B C | Good Y | w1_sa0 | w1_sa1 | A_sa0 | A_sa1 | Y_sa0 | Y_sa1 |
|-------|--------|--------|--------|-------|-------|-------|-------|
| 0 0 0 |   0    |   0    |   1    |   0   |   0   |   0   |   1   |
| 0 0 1 |   1    |   1    |   1    |   1   |   1   |   0   |   1   |
| 0 1 0 |   0    |   0    |   1    |   0   |   0   |   0   |   1   |
| 0 1 1 |   1    |   1    |   1    |   1   |   1   |   0   |   1   |
| 1 0 0 |   0    |   0    |   1    |   0   |   0   |   0   |   1   |
| 1 0 1 |   1    |   1    |   1    |   1   |   1   |   0   |   1   |
| 1 1 0 |   1    |   0    |   1    |   0   |   1   |   0   |   1   |
| 1 1 1 |   1    |   1    |   1    |   1   |   1   |   0   |   1   |

## Fault Coverage
- **Detectable** faults produce output differences for at least one input vector
- **Y_sa1** is detected by any vector where Good Y = 0 (e.g., ABC = 000, 010, 100)
- **w1_sa1** is detected by ABC = 110 (where Good Y = 1 but w1_sa1 forces AND output high, changing OR result only when C=0)
