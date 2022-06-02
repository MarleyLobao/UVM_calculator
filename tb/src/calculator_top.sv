import calculator_pkg::*;

module calculator_top;

  logic clk;
  logic rst;

  initial begin
    clk = 1;

    //Esse reset inicial é necessário para dar start no bloco.
    rst = 0;
    #20 rst = 1;
    //Assim como desligar o reset 1 ciclo depois para permitir
    //que a quantidade de ciclos definida seja alcançada.

    //Assim, rst pode ser completamente aleatório depois disso.
    #100  rst = 1;
    #3704 rst = 0;
    #56   rst = 1;
    #6000 rst = 0;
    #250  rst = 1;
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
