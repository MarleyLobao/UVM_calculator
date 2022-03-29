class calculator_seq_item extends uvm_sequence_item;
  `uvm_object_utils(calculator_seq_item)

  rand bit [1:0]  function_in;
  rand bit [7:0]  dat_a_in;
  rand bit [7:0]  dat_b_in;
  bit [15:0] out;

  function new(string name = "");
    super.new(name);
  endfunction

endclass