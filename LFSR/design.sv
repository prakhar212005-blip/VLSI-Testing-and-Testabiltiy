// design.sv
// Q4: 3-bit LFSR for polynomial P(x) = 1 + x^2 + x^3
// Feedback: f = q[2] XOR q[1]  (taps at x^3 and x^2)
// Produces maximal-length sequence of 2^3 - 1 = 7 states

`timescale 1ns/1ps

module lfsr3 (
  input  wire       clk,
  input  wire       rst,
  output reg  [2:0] q,    // 3-bit state register (q[2]=MSB, q[0]=LSB)
  output wire       so    // Serial output = LSB of register
);
  assign so = q[0];

  wire feedback;
  assign feedback = q[2] ^ q[1]; // Taps at x^3 and x^2

  // Fibonacci-type LFSR: shift left, feedback enters at LSB
  always @(posedge clk or posedge rst) begin
    if (rst)
      q <= 3'b001;               // Non-zero seed to start sequence
    else
      q <= { q[1], q[0], feedback }; // Shift: q[2]<=q[1], q[1]<=q[0], q[0]<=feedback
  end

endmodule
