# Q2 – Open pMOS Drain & Grounded nMOS Gate Fault Simulation

## Aim
Simulate and analyze the behavior of a CMOS inverter under two transistor-level faults using EDA tools.

## Files
- `design.sv` – Three inverter modules: good, open pMOS drain, grounded nMOS gate
- `testbench.sv` – Applies `in=1` and `in=0`, compares all three outputs

## How to Run on EDA Playground
1. Paste `design.sv` into **Design** panel
2. Paste `testbench.sv` into **Testbench** panel
3. Select **Icarus Verilog 10.3** as simulator; check **Open EPWave after run**
4. Click **Run**

## CMOS Inverter Truth Table (Ideal)
| Input (in) | Output (out) |
|-----------|-------------|
|     0     |      1      |
|     1     |      0      |

## Fault Models
| Fault | Description | Expected Effect |
|-------|-------------|----------------|
| Open pMOS Drain | pMOS transistor completely disconnected | Output fails to go HIGH when in=0 (no pull-up path to VDD) |
| Grounded nMOS Gate | nMOS gate permanently tied to GND (SA0) | nMOS never turns ON; output stays HIGH even when in=1 |

## Simulation Output (Expected)
| Time (ns) | in | Good Out | Fault(a) pMOS Open | Fault(b) nMOS SA0 |
|-----------|----|---------|--------------------|-------------------|
| 0–10      |  1 |    0    |         0          |         1         |
| 10–20     |  0 |    1    |   Floating / 0     |         1         |

## Waveform Interpretation
- **Good inverter**: Output toggles correctly (inverts input)
- **pMOS Open Fault**: Output cannot rise to logic 1 when input is 0 (no VDD path)
- **nMOS Gate SA0**: Output is always HIGH — nMOS never conducts regardless of input
