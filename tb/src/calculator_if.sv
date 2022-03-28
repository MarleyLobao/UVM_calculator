/*
Author: Hugo G.
Description: This file models a calculator RTL interface
*/

interface calculator_if(
  input clk, rst_n
);
  logic [7:0] dat_a_in;
  logic [7:0] dat_b_in;
  logic [1:0] function_in;
  logic [15:0] out;

  modport dut(input dat_a_in,
              input dat_b_in,
              input function_in,
              input clk,
              input rst_n,
              output out);

  modport tb(output dat_a_in,
              output dat_b_in,
              output function_in,
              input clk,
              input rst_n,
              input out);

endinterface : calculator_io


