module tb ();
  reg clk = 0;
  wire out;
  
  always #10 clk <= ~clk;

  int_clk_div dut(
    .clk(clk),
    .out(out)
  );

  initial begin
    $display("=== SIMULATION STARTED ===");
    #1000;
    $display("=== SIMULATION FINISHED ===");
    $finish;
  end
endmodule
