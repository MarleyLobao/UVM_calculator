module calculator_assertions(
  input clk,
  input rst_n,
  input [1:0] function_in,
  input [7:0] dat_a_in,
  input [7:0] dat_b_in,
  input [15:0] out
);

  sequence zero_div_with_A_pos;
    (!dat_b_in) && (function_in == 2'b11) && (!dat_a_in[7]);
  endsequence

  sequence out_max;
    ##LATENCY_BLOCK (out == 16'd32767);
  endsequence

  sequence zero_div_with_A_neg;
    (!dat_b_in) && (function_in == 2'b11) && (dat_a_in[7]);
  endsequence

  sequence out_min;
    ##LATENCY_BLOCK (out == -16'd32768);
  endsequence

  sequence in_zeros_diff;
    ((dat_a_in != -dat_b_in) & (!function_in)) |                   //sum
    ((dat_a_in != dat_b_in) & (function_in == 2'b01)) |            //sub
    ((dat_a_in != 0) & (dat_b_in != 0) & (function_in == 2'b10)) | //mul
    ((dat_a_in != 0) & (function_in == 2'b11));                    //div
  endsequence

  property zero_division_A_pos;
    @(posedge clk) disable iff(!rst_n)
      zero_div_with_A_pos |-> out_max;
  endproperty

  property zero_division_A_neg;
    @(posedge clk) disable iff(!rst_n)
      zero_div_with_A_neg |-> out_min;
  endproperty

  property start_reset;
    @(posedge clk)
      $fell(rst_n) |-> (out == 16'b0);
  endproperty

  property end_reset;
    @(posedge clk)
      $rose(rst_n) |-> s_eventually (out != 16'b0);
  endproperty

  property after_rst_in_zeros_diff;
    @(posedge clk)
      $rose(rst_n) |-> s_eventually in_zeros_diff;
  endproperty

  zero_div_A_pos_assert: assert property (zero_division_A_pos);
  zero_div_A_neg_assert: assert property (zero_division_A_neg);
  start_reset_assert: assert property (start_reset);
  end_reset_assert: assert property (end_reset);

  after_rst_in_zeros_diff_assume: assume property (after_rst_in_zeros_diff);
endmodule
