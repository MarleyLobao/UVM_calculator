/*
 Author: Hugo G.
 Description: This files defines a basic sequence item 
*/

class calculator_seq_item extends uvm_sequence_item;
  rand bit [7:0] m_dat_a_in;
  rand bit [7:0] m_dat_b_in;
  rand bit [1:0] m_function_in;
       bit [15:0] m_out;

  `uvm_object_utils_begin(computation)
      `uvm_field_int(m_dat_a_in, UVM_ALL_ON|UVM_HEX)
      `uvm_field_int(m_dat_b_in, UVM_ALL_ON|UVM_HEX)
      `uvm_field_int(m_function_in, UVM_ALL_ON|UVM_HEX)
      `uvm_field_int(m_out, UVM_ALL_ON|UVM_HEX)
  `uvm_object_utils_end

endclass : calculator_seq_item
