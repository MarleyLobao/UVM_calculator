import calculator_pkg::*;

module calculator_top;

  logic clk;
  logic rst;
  int clk_rst_duration, rst_probability;

  initial begin
    clk = 1;
    clk_rst_duration = 0;
    rst_probability = 0;

    //This initial reset is needed to start the block.
    rst = 0;

    //rst can be completely random after that.
    forever begin
      if(rst) clk_rst_duration = $urandom_range(min_clk_duration_out_rst, max_clk_duration_out_rst);
      else    clk_rst_duration = $urandom_range(min_clk_duration_in_rst, max_clk_duration_in_rst);

      #(clk_rst_duration*CLK_PERIOD);
      if(rst_probability < change_rst_percentage) rst = !rst;
      rst_probability = $urandom_range(0,100);
    end
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
    .function_in(vif_top.function_in),
    .dat_a_in(vif_top.dat_a_in),
    .dat_b_in(vif_top.dat_b_in),
    .out(vif_top.out)
  );

  initial begin
    $timeformat(-9, 0, "ns", 6);

    uvm_config_db#(virtual calculator_if)::set(uvm_root::get(), "*", "vif", vif_top);

    run_test("calculator_test");
  end
endmodule
