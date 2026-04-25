# Good and Faulty Behavior: 3-input NAND & NOR Gate

## Aim
Simulate good (fault-free) and faulty (stuck-at fault) behavior of 3-input NAND and NOR logic gates using EDA tools.

## Files
- `design.sv` – RTL modules: `nand3_gate` and `nor3_gate`
- `testbench.sv` – Applies all 8 input combinations with SA0/SA1 faults on every input and output

## How to Run on EDA Playground
1. Go to [https://www.edaplayground.com](https://www.edaplayground.com)
2. Paste `design.sv` into the **Design** panel
3. Paste `testbench.sv` into the **Testbench** panel
4. Select **Icarus Verilog 10.3** as simulator
5. Check **Open EPWave after run**
6. Click **Run**

## Logic Functions
- **NAND**: `Y = ~(A & B & C)` — Output is 0 only when ALL inputs are 1
- **NOR**: `Y = ~(A | B | C)` — Output is 1 only when ALL inputs are 0

## Fault Model
| Fault | Description |
|-------|-------------|
| SA0 (Stuck-at-0) | Signal line permanently driven to logic 0 |
| SA1 (Stuck-at-1) | Signal line permanently driven to logic 1 |

## NAND Gate Fault Verification Table
| A B C | Good | A_sa0 | A_sa1 | B_sa0 | B_sa1 | C_sa0 | C_sa1 | Y_sa0 | Y_sa1 |
|-------|------|-------|-------|-------|-------|-------|-------|-------|-------|
| 0 0 0 |  1   |   1   |   1   |   1   |   1   |   1   |   1   |   0   |   1   |
| 0 0 1 |  1   |   1   |   1   |   1   |   1   |   1   |   1   |   0   |   1   |
| 0 1 0 |  1   |   1   |   1   |   1   |   1   |   1   |   1   |   0   |   1   |
| 0 1 1 |  1   |   1   |   0   |   1   |   1   |   1   |   0   |   0   |   1   |
| 1 0 0 |  1   |   1   |   1   |   1   |   1   |   1   |   1   |   0   |   1   |
| 1 0 1 |  1   |   1   |   1   |   1   |   0   |   1   |   1   |   0   |   1   |
| 1 1 0 |  1   |   1   |   1   |   1   |   1   |   1   |   0   |   0   |   1   |
| 1 1 1 |  0   |   1   |   0   |   1   |   0   |   1   |   0   |   0   |   1   |

## NOR Gate Fault Verification Table
| A B C | Good | A_sa0 | A_sa1 | B_sa0 | B_sa1 | C_sa0 | C_sa1 | Y_sa0 | Y_sa1 |
|-------|------|-------|-------|-------|-------|-------|-------|-------|-------|
| 0 0 0 |  1   |   1   |   0   |   1   |   0   |   1   |   0   |   0   |   1   |
| 0 0 1 |  0   |   0   |   0   |   0   |   1   |   0   |   0   |   0   |   1   |
| 0 1 0 |  0   |   0   |   0   |   1   |   0   |   0   |   0   |   0   |   1   |
| 0 1 1 |  0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   1   |
| 1 0 0 |  0   |   1   |   0   |   0   |   0   |   0   |   0   |   0   |   1   |
| 1 0 1 |  0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   1   |
| 1 1 0 |  0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   1   |
| 1 1 1 |  0   |   0   |   0   |   0   |   0   |   0   |   0   |   0   |   1   |
