`timescale 1ns/1ps

import uvm_pkg::*;

package calculator_pkg;
  parameter CLK_PERIOD     = 20;
  parameter LATENCY_BLOCK  = 2;

  parameter int min_clk_duration_in_rst  = 2;
  parameter int max_clk_duration_in_rst  = 10;
  parameter int min_clk_duration_out_rst = 50;
  parameter int max_clk_duration_out_rst = 100;
  parameter int change_rst_percentage    = 30;

  `include "uvm_macros.svh"

  `include "./calculator_seq_item.sv"
  `include "./calculator_sequence.sv"

  `include "./calculator_driver.sv"
  `include "./calculator_monitor.sv"
  `include "./calculator_agent.sv"

  `include "./calculator_comparator.sv"
  `include "./calculator_refmod.sv"
  `include "./calculator_scoreboard.sv"
  `include "./calculator_coverage.sv"
  `include "./calculator_env.sv"
  `include "./calculator_test.sv"
endpackage
