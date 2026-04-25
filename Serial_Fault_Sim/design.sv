// design.sv
// Q3: Serial Fault Simulation – Design Under Test (DUT)
// Function: Y = (A & B) | C

module dut (
  output wire Y,
  input  wire A, B, C
);
  // Internal net for AND gate output
  wire w1;

  // Gate-level implementation: Y = (A & B) | C
  and u_and (w1, A, B);   // w1 = A & B
  or  u_or  (Y,  w1, C);  // Y  = w1 | C

endmodule
