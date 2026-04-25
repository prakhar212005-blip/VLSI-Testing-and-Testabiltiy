// testbench.sv
// Q1: Fault simulation for 3-input NAND and NOR gates
// Simulates stuck-at-0 (SA0) and stuck-at-1 (SA1) faults on all inputs and output

`timescale 1ns/1ps

module tb_gates;

  // Input registers for stimulus
  reg A, B, C;

  // Output wires to observe
  // NAND gate outputs
  wire Y_nand_good;
  wire Y_nand_A_sa0, Y_nand_A_sa1;
  wire Y_nand_B_sa0, Y_nand_B_sa1;
  wire Y_nand_C_sa0, Y_nand_C_sa1;
  wire Y_nand_Y_sa0, Y_nand_Y_sa1;

  // NOR gate outputs
  wire Y_nor_good;
  wire Y_nor_A_sa0, Y_nor_A_sa1;
  wire Y_nor_B_sa0, Y_nor_B_sa1;
  wire Y_nor_C_sa0, Y_nor_C_sa1;
  wire Y_nor_Y_sa0, Y_nor_Y_sa1;

  // Instantiate the 3-input NAND gate (good / fault-free)
  nand3_gate u_nand_good  (.Y(Y_nand_good),  .A(A),    .B(B),    .C(C));

  // NAND - Input Faults
  nand3_gate u_nand_A_sa0 (.Y(Y_nand_A_sa0), .A(1'b0), .B(B),    .C(C));  // A stuck-at-0
  nand3_gate u_nand_A_sa1 (.Y(Y_nand_A_sa1), .A(1'b1), .B(B),    .C(C));  // A stuck-at-1
  nand3_gate u_nand_B_sa0 (.Y(Y_nand_B_sa0), .A(A),    .B(1'b0), .C(C));  // B stuck-at-0
  nand3_gate u_nand_B_sa1 (.Y(Y_nand_B_sa1), .A(A),    .B(1'b1), .C(C));  // B stuck-at-1
  nand3_gate u_nand_C_sa0 (.Y(Y_nand_C_sa0), .A(A),    .B(B),    .C(1'b0)); // C stuck-at-0
  nand3_gate u_nand_C_sa1 (.Y(Y_nand_C_sa1), .A(A),    .B(B),    .C(1'b1)); // C stuck-at-1

  // NAND - Output Faults (force output wire directly)
  assign Y_nand_Y_sa0 = 1'b0; // Output stuck-at-0
  assign Y_nand_Y_sa1 = 1'b1; // Output stuck-at-1

  // Instantiate the 3-input NOR gate (good / fault-free)
  nor3_gate u_nor_good    (.Y(Y_nor_good),   .A(A),    .B(B),    .C(C));

  // NOR - Input Faults
  nor3_gate u_nor_A_sa0   (.Y(Y_nor_A_sa0),  .A(1'b0), .B(B),    .C(C));  // A stuck-at-0
  nor3_gate u_nor_A_sa1   (.Y(Y_nor_A_sa1),  .A(1'b1), .B(B),    .C(C));  // A stuck-at-1
  nor3_gate u_nor_B_sa0   (.Y(Y_nor_B_sa0),  .A(A),    .B(1'b0), .C(C));  // B stuck-at-0
  nor3_gate u_nor_B_sa1   (.Y(Y_nor_B_sa1),  .A(A),    .B(1'b1), .C(C));  // B stuck-at-1
  nor3_gate u_nor_C_sa0   (.Y(Y_nor_C_sa0),  .A(A),    .B(B),    .C(1'b0)); // C stuck-at-0
  nor3_gate u_nor_C_sa1   (.Y(Y_nor_C_sa1),  .A(A),    .B(B),    .C(1'b1)); // C stuck-at-1

  // NOR - Output Faults
  assign Y_nor_Y_sa0 = 1'b0; // Output stuck-at-0
  assign Y_nor_Y_sa1 = 1'b1; // Output stuck-at-1

  initial begin
    // Setup waveform dumping
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_gates);

    // Apply all 8 input combinations
    $display("Time | A B C | NAND_Good | NOR_Good | NAND_A_sa0 | NAND_A_sa1 | NOR_A_sa0 | NOR_A_sa1");
    $monitor("%4t | %b %b %b | %b         | %b        | %b          | %b          | %b         | %b",
      $time, A, B, C, Y_nand_good, Y_nor_good, Y_nand_A_sa0, Y_nand_A_sa1, Y_nor_A_sa0, Y_nor_A_sa1);

    {A,B,C} = 3'b000; #10;
    {A,B,C} = 3'b001; #10;
    {A,B,C} = 3'b010; #10;
    {A,B,C} = 3'b011; #10;
    {A,B,C} = 3'b100; #10;
    {A,B,C} = 3'b101; #10;
    {A,B,C} = 3'b110; #10;
    {A,B,C} = 3'b111; #10;

    #10 $finish;
  end

endmodule
