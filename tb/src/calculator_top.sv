import calculator_pkg::*;

module calculator_top;

  logic clk;
  logic rst;

  initial begin
    clk = 1;
    rst = 0;
    #100 rst = 1;
    #56 rst = 0;
    #92 rst = 1;
    #6000 rst = 0;
    #250 rst = 1;
  end

  always #10 clk = !clk;

  calculator_if dut_if(.clk(clk), .rst_n(rst));
  
  calculator my_calculator(
              .clk(clk),
              .rst_n(rst),
              .function_in(dut_if.function_in),
              .dat_a_in(dut_if.dat_a_in),
              .dat_b_in(dut_if.dat_b_in),
              .out(dut_if.out)
  );

  initial begin
    
    uvm_config_db#(virtual calculator_if)::set(uvm_root::get(), "*", "vif", dut_if);

    run_test("calculator_test");
  end
endmodule
