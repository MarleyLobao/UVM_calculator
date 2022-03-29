interface calculator_if(input clk, rst_n);
    logic [1:0]  function_in;
    logic [7:0]  dat_a_in;
    logic [7:0]  dat_b_in;
    logic [15:0] out;
    
    modport mst(input clk, rst_n, out, output dat_a_in, dat_b_in, function_in);
    modport slv(input clk, rst_n, dat_a_in, dat_b_in, function_in, output out);
endinterface