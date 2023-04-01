import uvm_pkg::*;

package calculator_pkg;
  parameter CLK_PERIOD = 20;

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
