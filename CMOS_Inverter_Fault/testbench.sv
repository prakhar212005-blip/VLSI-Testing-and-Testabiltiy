// testbench.sv
// Q2: Testbench for CMOS Inverter – Good vs Faulty outputs

`timescale 1ns/1ps

module tb_fault_sim;

  reg in;
  wire out_good;
  wire out_pmos_fault_a;   // Open pMOS drain
  wire out_nmos_fault_b;   // Grounded nMOS gate (SA0)

  // Instantiate good inverter
  inverter_good dut_good (
    .in(in),
    .out(out_good)
  );

  // Instantiate faulty inverter (a): open pMOS drain
  inverter_pmos_open_fault dut_pmos_fault_a (
    .in(in),
    .out(out_pmos_fault_a)
  );

  // Instantiate faulty inverter (b): grounded nMOS gate
  inverter_nmos_gate_sa0 dut_nmos_fault_b (
    .in(in),
    .out(out_nmos_fault_b)
  );

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_fault_sim);

    $monitor("Time=%0t | in=%b | Good=%b | Fault(a)_pMOS_Open=%b | Fault(b)_nMOS_SA0=%b",
      $time, in, out_good, out_pmos_fault_a, out_nmos_fault_b);

    in = 1; #10;  // Test input HIGH → Good should give LOW
    in = 0; #10;  // Test input LOW  → Good should give HIGH

    #10;
    $finish;
  end

endmodule
