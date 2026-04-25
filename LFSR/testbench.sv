// testbench.sv
// Q4: Testbench for 3-bit LFSR with P(x) = 1 + x^2 + x^3

`timescale 1ns/1ps

module tb_lfsr3();

  reg        clk, rst;
  wire [2:0] q;
  wire       so;

  // Instantiate the LFSR
  lfsr3 uut (
    .clk(clk),
    .rst(rst),
    .q(q),
    .so(so)
  );

  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_lfsr3);

    $display("Clock | q[2:0] | so | Decimal State");
    $display("------+--------+----+--------------");

    // Apply reset
    rst = 1; #10;
    rst = 0; #10;

    // Display state at each clock edge (7 + some extra cycles)
    repeat (9) begin
      @(posedge clk);
      #1; // Small delay to let values settle
      $display("  %0t   |  %3b   |  %b |     %0d",
        $time, q, so, q);
    end

    $finish;
  end

endmodule
