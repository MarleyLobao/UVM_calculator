import calculator_pkg::*;

module calculator_top;

  logic clk;
  logic rst;

  initial begin
    clk = 1;

    //This initial reset is needed to start the block.
    rst = 0;
    #CLK_PERIOD rst = 1;
    //To turn off the reset 1 cycle later to allow
    //that the defined number of cycles is reached.

    //So rst can be completely random after that.
    #100  rst = 1;
    #3704 rst = 0;
    #56   rst = 1;
    #6000 rst = 0;
    #250  rst = 1;
  end

  always #(CLK_PERIOD/2) clk = !clk;

  calculator_if vif_top(.clk(clk), .rst_n(rst));
  
  calculator my_calculator(
              .clk(clk),
              .rst_n(rst),
              .function_in(vif_top.function_in),
              .dat_a_in(vif_top.dat_a_in),
              .dat_b_in(vif_top.dat_b_in),
              .out(vif_top.out)
  );

  calculator_assertions calc_assert(
              .clk(clk),
              .rst_n(rst),
              .func_in(vif_top.function_in),
              .A_in(vif_top.dat_a_in),
              .B_in(vif_top.dat_b_in),
              .out(vif_top.out)
  );

  initial begin
    $timeformat(-9, 0, "ns", 6);

    uvm_config_db#(virtual calculator_if)::set(uvm_root::get(), "*", "vif", vif_top);

    run_test("calculator_test");
  end
endmodule
