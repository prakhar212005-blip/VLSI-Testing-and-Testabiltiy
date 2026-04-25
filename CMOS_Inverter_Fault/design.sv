// design.sv
// Q2: CMOS Inverter – Good, Open pMOS Drain, and Grounded nMOS Gate

`timescale 1ns/1ps

// ─────────────────────────────────────────────
// 1. Good (fault-free) CMOS Inverter
//    pMOS: input=in, output=out, VDD (supply1)
//    nMOS: input=in, output=out, GND (supply0)
// ─────────────────────────────────────────────
module inverter_good (
  input  in,
  output out
);
  supply1 vdd;
  supply0 gnd;
  pmos p1 (out, vdd, in);   // (drain, source, gate)
  nmos n1 (out, gnd, in);   // (drain, source, gate)
endmodule

// ─────────────────────────────────────────────
// 2. Fault (a): Open pMOS Drain
//    pMOS transistor is disconnected (open).
//    Only nMOS remains → output stuck LOW when in=1,
//    floating/0 when in=0 (no pull-up path to VDD)
// ─────────────────────────────────────────────
module inverter_pmos_open_fault (
  input  in,
  output out
);
  supply0 gnd;
  // pMOS removed — no pull-up path to VDD
  nmos n1 (out, gnd, in);   // nMOS still present
endmodule

// ─────────────────────────────────────────────
// 3. Fault (b): Grounded nMOS Gate (SA0)
//    nMOS gate is permanently tied to GND.
//    nMOS never turns ON → output always HIGH
//    (pulled up by pMOS regardless of input)
// ─────────────────────────────────────────────
module inverter_nmos_gate_sa0 (
  input  in,
  output out
);
  supply1 vdd;
  supply0 gnd;
  pmos p1 (out, vdd, in);   // pMOS still controlled by input
  nmos n1 (out, gnd, gnd);  // gate tied to GND → always OFF
endmodule
