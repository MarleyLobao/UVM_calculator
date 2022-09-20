class calculator_seq_item extends uvm_sequence_item;

  rand bit [1:0]  function_in;
  rand bit signed [7:0]  dat_a_in;
  rand bit signed [7:0]  dat_b_in;
  bit signed [15:0] out;

  function new(string name = "");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(calculator_seq_item)
  `uvm_field_int(function_in, UVM_ALL_ON|UVM_BIN)
  `uvm_field_int(dat_a_in, UVM_ALL_ON|UVM_BIN)
  `uvm_field_int(dat_b_in, UVM_ALL_ON|UVM_BIN)
  `uvm_field_int(out, UVM_ALL_ON|UVM_BIN)
  `uvm_object_utils_end

  function string convert2string();
   return $sformatf("\nfunction_in: %0d\nA: %0d\nB: %0d\nout: %0d\n",function_in,dat_a_in,dat_b_in,out);
  endfunction :convert2string
endclass
