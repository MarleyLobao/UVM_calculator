/*
Author: Hugo G.
Description: This file models a calculator RTL interface
*/

interface calculator_io(
  input clk, rst_n
);
  logic [7:0] operand_A;
  logic [7:0] operand_B;
  logic [1:0] op_code;
  logic [15:0] result;

  modport dut(input operand_A,
              input operand_B,
              input op_code,
              input clk,
              input rst_n,
              output data);

  modport tb(output operand_A,
              output operand_B,
              output op_code,
              output clk,
              output rst_n,
              input data);

endinterface : calculator_io


