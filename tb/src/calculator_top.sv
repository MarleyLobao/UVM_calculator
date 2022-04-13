module calculator_top;
  import uvm_pkg::*;
  import calculator_pkg::*;

  logic clk;
  logic rst;

  initial begin
    clk = 1;
    rst = 1;
    #20 rst = 0;
    #20 rst = 1;
  end

  always #10 clk = !clk;

  calculator_if dut_if(.clk(clk), .rst(rst));
  
  calculator my_calculator(
              .clk_i(clk),
              .rstn_i(rst),
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