module calculator_assertions(
  input clk,
  input rst_n,
  input [1:0] func_in,
  input [7:0] A_in,
  input [7:0] B_in,
  input [15:0] out
);

  sequence zero_div_with_A_pos;
    (!B_in) && (func_in == 2'b11) && (!A_in[7]); 
  endsequence

  sequence out_max;
    ##LATENCY_BLOCK (out == 16'd32767);
  endsequence

  sequence zero_div_with_A_neg;
    (!B_in) && (func_in == 2'b11) && (A_in[7]);
  endsequence

  sequence out_min;
    ##LATENCY_BLOCK (out == -16'd32768);
  endsequence

  property zero_division_A_pos;
    @(posedge clk) disable iff(!rst_n)
      zero_div_with_A_pos |-> out_max;
  endproperty

  property zero_division_A_neg;
    @(posedge clk) disable iff(!rst_n)
      zero_div_with_A_neg |-> out_min;
  endproperty

  zero_div_assert_A_pos: assert property (zero_division_A_pos);
  zero_div_assert_A_neg: assert property (zero_division_A_neg);
endmodule