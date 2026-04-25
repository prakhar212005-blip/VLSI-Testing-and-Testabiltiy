// design.sv
// Q5: 4-bit Scan Chain Register using Scan Flip-Flops
// Supports Normal Mode (parallel load) and Scan Mode (serial shift)

`timescale 1ns/1ps

// ─────────────────────────────────────────────────────────────
// Scan Flip-Flop Module
// scan_enable=0 → Normal mode: stores data_in on clock edge
// scan_enable=1 → Scan  mode: stores scan_in  on clock edge
// ─────────────────────────────────────────────────────────────
module scan_ff (
  input  wire clk,
  input  wire rst,
  input  wire scan_enable,
  input  wire data_in,     // Functional (parallel) input
  input  wire scan_in,     // Serial scan input
  output reg  data_out     // Registered output
);
  wire d_mux;
  // Multiplexer: select between functional input and scan input
  assign d_mux = (scan_enable == 1'b1) ? scan_in : data_in;

  always @(posedge clk or posedge rst) begin
    if (rst)
      data_out <= 1'b0;  // Reset clears all flip-flops
    else
      data_out <= d_mux;
  end

endmodule

// ─────────────────────────────────────────────────────────────
// 4-bit Scan Chain Register
// Chain: scan_in → FF0 → FF1 → FF2 → FF3 → scan_out
// ─────────────────────────────────────────────────────────────
module scan_register_4bit (
  input  wire       clk,
  input  wire       rst,
  input  wire       scan_enable,
  input  wire       scan_in,              // Serial test data input
  input  wire [3:0] parallel_data_in,     // Parallel functional inputs
  output wire       scan_out,             // Serial test data output
  output wire [3:0] parallel_data_out     // Parallel outputs
);

  // FF0: first in chain, scan_in comes from external scan_in port
  scan_ff ff0 (
    .clk(clk),
    .rst(rst),
    .scan_enable(scan_enable),
    .data_in(parallel_data_in[0]),
    .scan_in(scan_in),
    .data_out(parallel_data_out[0])
  );

  // FF1: scan_in comes from FF0's output
  scan_ff ff1 (
    .clk(clk),
    .rst(rst),
    .scan_enable(scan_enable),
    .data_in(parallel_data_in[1]),
    .scan_in(parallel_data_out[0]),
    .data_out(parallel_data_out[1])
  );

  // FF2: scan_in comes from FF1's output
  scan_ff ff2 (
    .clk(clk),
    .rst(rst),
    .scan_enable(scan_enable),
    .data_in(parallel_data_in[2]),
    .scan_in(parallel_data_out[1]),
    .data_out(parallel_data_out[2])
  );

  // FF3: scan_in comes from FF2's output
  scan_ff ff3 (
    .clk(clk),
    .rst(rst),
    .scan_enable(scan_enable),
    .data_in(parallel_data_in[3]),
    .scan_in(parallel_data_out[2]),
    .data_out(parallel_data_out[3])
  );

  // Chain output: last FF's output becomes scan_out
  assign scan_out = parallel_data_out[3];

endmodule
