// testbench.sv
// Q3: Serial Fault Simulation for Y = (A & B) | C
// Injects faults one at a time (serially) and reports detected/undetected faults

`timescale 1ns/1ps

module tb_serial_fault_sim;

  // Stimulus and output signals
  reg A, B, C;
  wire Y_good;    // Output of the fault-free (golden) circuit
  wire Y_faulty;  // Output of the circuit under fault injection

  // Fault control string for display
  reg [8*12:1] current_fault;

  // ─────────────────────────────────
  // Instantiate golden (fault-free) model
  // ─────────────────────────────────
  dut u_good (
    .Y(Y_good),
    .A(A), .B(B), .C(C)
  );

  // ─────────────────────────────────
  // Instantiate faulty model
  // Note: 'u_faulty' is the hierarchical path used in 'force' statements
  // ─────────────────────────────────
  dut u_faulty (
    .Y(Y_faulty),
    .A(A), .B(B), .C(C)
  );

  // ─────────────────────────────────
  // Task: Apply all 8 input test vectors
  // ─────────────────────────────────
  task apply_all_vectors;
    integer i;
    for (i = 0; i < 8; i = i + 1) begin
      {A, B, C} = i;
      #10; // Wait 10ns for signals to settle
      if (Y_good !== Y_faulty) begin
        $display("  -> Fault '%s' DETECTED by vector ABC = %3b. (Good: %b, Faulty: %b)",
          current_fault, {A, B, C}, Y_good, Y_faulty);
      end
    end
  endtask

  // ─────────────────────────────────
  // Main simulation block
  // ─────────────────────────────────
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_serial_fault_sim);

    A = 0; B = 0; C = 0;
    $display("--- Starting Serial Fault Simulation for Y = (A & B) | C ---");

    // === Fault Run 1: Input A stuck-at-0 ===
    current_fault = "A_sa0";
    $display("\n[1] Injecting fault: %s", current_fault);
    force u_faulty.A = 1'b0;
    apply_all_vectors();
    release u_faulty.A;
    #20;

    // === Fault Run 2: Input A stuck-at-1 ===
    current_fault = "A_sa1";
    $display("\n[2] Injecting fault: %s", current_fault);
    force u_faulty.A = 1'b1;
    apply_all_vectors();
    release u_faulty.A;
    #20;

    // === Fault Run 3: Internal net w1 stuck-at-0 ===
    current_fault = "w1_sa0";
    $display("\n[3] Injecting fault: %s (internal AND output net)", current_fault);
    force u_faulty.w1 = 1'b0;
    apply_all_vectors();
    release u_faulty.w1;
    #20;

    // === Fault Run 4: Internal net w1 stuck-at-1 ===
    current_fault = "w1_sa1";
    $display("\n[4] Injecting fault: %s (internal AND output net)", current_fault);
    force u_faulty.w1 = 1'b1;
    apply_all_vectors();
    release u_faulty.w1;
    #20;

    // === Fault Run 5: Output Y stuck-at-0 ===
    current_fault = "Y_sa0";
    $display("\n[5] Injecting fault: %s", current_fault);
    force u_faulty.Y = 1'b0;
    apply_all_vectors();
    release u_faulty.Y;
    #20;

    // === Fault Run 6: Output Y stuck-at-1 ===
    current_fault = "Y_sa1";
    $display("\n[6] Injecting fault: %s", current_fault);
    force u_faulty.Y = 1'b1;
    apply_all_vectors();
    release u_faulty.Y;
    #20;

    $display("\n--- Simulation Complete ---");
    $finish;
  end

endmodule
