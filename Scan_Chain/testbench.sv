// testbench.sv
// Q5: Testbench for 4-bit Scan Chain
// Tests: Reset → Normal Mode (parallel load) → Scan-Out → Scan-In → Normal Mode

`timescale 1ns/1ps

module tb_scan_chain;

  reg       clk;
  reg       rst;
  reg       scan_enable;
  reg       scan_in;
  reg [3:0] parallel_data_in;

  wire       scan_out;
  wire [3:0] parallel_data_out;

  // Instantiate the 4-bit scan chain register
  scan_register_4bit uut (
    .clk(clk),
    .rst(rst),
    .scan_enable(scan_enable),
    .scan_in(scan_in),
    .parallel_data_in(parallel_data_in),
    .scan_out(scan_out),
    .parallel_data_out(parallel_data_out)
  );

  // Clock generation: 10ns period (5ns high, 5ns low)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_scan_chain);

    $monitor("Time=%0t | rst=%b | SE=%b | par_in=%b | scan_in=%b | par_out=%b | scan_out=%b",
      $time, rst, scan_enable, parallel_data_in, scan_in, parallel_data_out, scan_out);

    // ── Step 1: RESET ──
    rst              = 1;
    scan_enable      = 0;
    parallel_data_in = 4'b0000;
    scan_in          = 0;
    #20;  // Hold reset for 2 cycles
    rst = 0;
    #10;

    // ── Step 2: NORMAL MODE – Load 1010 in parallel ──
    $display("--- 1. NORMAL MODE (Loading 4'b1010) ---");
    scan_enable      = 0;
    parallel_data_in = 4'b1010;
    #10;   // One clock cycle for parallel load
    // parallel_data_out should now be 4'b1010

    // ── Step 3: SCAN-OUT MODE – Shift stored data out serially ──
    $display("--- 2. SCAN-OUT MODE (Shifting 1010 out) ---");
    scan_enable = 1;
    scan_in     = 0;   // Shift in 0s while reading stored bits
    #10; #10; #10; #10; // 4 clock cycles to shift all 4 bits out

    // ── Step 4: SCAN-IN MODE – Serially load 0110 ──
    $display("--- 3. SCAN-IN MODE (Shifting 0110 in, LSB first) ---");
    scan_enable = 1;
    scan_in = 0; #10;  // FF0 gets 0 (bit[0] of 0110)
    scan_in = 1; #10;  // FF0 gets 1 (bit[1] of 0110)
    scan_in = 1; #10;  // FF0 gets 1 (bit[2] of 0110)
    scan_in = 0; #10;  // FF0 gets 0 (bit[3] of 0110)

    // ── Step 5: RETURN TO NORMAL MODE ──
    $display("--- 4. RETURN TO NORMAL MODE ---");
    scan_enable = 0;
    #20;

    $finish;
  end

endmodule
