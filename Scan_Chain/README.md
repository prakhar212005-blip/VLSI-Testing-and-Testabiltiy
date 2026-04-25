# 4-bit Scan Chain (Open-Ended Problem)

## Aim
Design and simulate a 4-bit scan chain using Verilog HDL, demonstrating both normal (parallel) and scan (serial) modes for Design-for-Testability (DFT) verification.

## Files
- `design.sv` – `scan_ff` module and `scan_register_4bit` module (4 scan flip-flops chained)
- `testbench.sv` – Tests Reset, Normal Mode, Scan-Out, Scan-In, and return to Normal Mode

## How to Run on EDA Playground
1. Paste `design.sv` into **Design** panel
2. Paste `testbench.sv` into **Testbench** panel
3. Select **Icarus Verilog 10.3**; check **Open EPWave after run**
4. Click **Run**

## Scan Chain Architecture
```
scan_in → [FF0] → [FF1] → [FF2] → [FF3] → scan_out
            ↓        ↓       ↓       ↓
          out[0]  out[1]  out[2]  out[3]
```

Each scan flip-flop has:
- **D** (data_in): functional parallel input
- **SI** (scan_in): serial test data input from previous FF
- **SE** (scan_enable): 0 = Normal mode, 1 = Scan mode

## Mode Summary
| Mode | scan_enable | Behavior |
|------|-------------|----------|
| Normal | 0 | All FFs load `parallel_data_in` simultaneously on clock edge |
| Scan | 1 | Each FF captures the output of the previous FF (serial shift) |

## Simulation Steps
| Step | Mode | Action | Expected Result |
|------|------|--------|----------------|
| 1 | Reset | rst=1 for 2 cycles | All outputs = 0000 |
| 2 | Normal | Load 4'b1010 | parallel_data_out = 1010 |
| 3 | Scan-Out | SE=1, shift 4 cycles | Bits of 1010 appear at scan_out |
| 4 | Scan-In | SE=1, shift in 0110 | Chain stores 0110 |
| 5 | Normal | SE=0 | New pattern visible |

## Key DFT Concepts
- **Controllability**: Scan mode lets testers write any pattern into every FF
- **Observability**: Scan mode lets testers read out the state of every FF
- **Fault detection**: By loading known patterns and reading results, stuck-at faults can be detected
