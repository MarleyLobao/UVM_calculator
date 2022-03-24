/*
 Author: Hugo G.
 Description: This files defines a basic sequence item 
*/

class computation extends uvm_sequence_item;
  rand bit [7:0] m_operand_A;
  rand bit [7:0] m_operand_B;
  rand bit [1:0] m_opcode;
  rand bit [15:0] m_output;

  `uvm_object_utils_begin(computation)
      `uvm_field_int(m_operand_A, UVM_ALL_ON|UVM_HEX)
      `uvm_field_int(m_operand_B, UVM_ALL_ON|UVM_HEX)
      `uvm_field_int(m_opcode, UVM_ALL_ON|UVM_HEX)
      `uvm_field_int(m_output, UVM_ALL_ON|UVM_HEX)
  `uvm_object_utils_end

endclass : computation
