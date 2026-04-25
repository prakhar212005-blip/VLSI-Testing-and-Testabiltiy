// design.sv
// Q1: Good (fault-free) 3-input NAND and NOR gates

// 3-input NAND gate module
// Boolean expression: Y = ~(A & B & C)
module nand3_gate (
  output wire Y,
  input  wire A, B, C
);
  assign Y = ~(A & B & C); // Logic: NOT (A AND B AND C)
endmodule

// 3-input NOR gate module
// Boolean expression: Y = ~(A | B | C)
module nor3_gate (
  output wire Y,
  input  wire A, B, C
);
  assign Y = ~(A | B | C); // Logic: NOT (A OR B OR C)
endmodule
