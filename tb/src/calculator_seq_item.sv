class calculator_seq_item extends uvm_sequence_item;

  rand bit [1:0]  function_in;
  rand bit signed [7:0]  dat_a_in;
  rand bit signed [7:0]  dat_b_in;
  bit signed [15:0] out;

  constraint operand_A_c{ dat_a_in dist {127:=120, [1:126]:=1, 0:=120, -1:=120, [-127:-2]:=1, -128:=120}; }
  constraint operand_B_c{ dat_b_in dist {127:=120, [1:126]:=1, 0:=120, -1:=120, [-127:-2]:=1, -128:=120}; }

  function new(string name = "");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(calculator_seq_item)
  `uvm_field_int(function_in, UVM_ALL_ON|UVM_UNSIGNED)
  `uvm_field_int(dat_a_in, UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(dat_b_in, UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(out, UVM_ALL_ON|UVM_NOCOMPARE|UVM_DEC)
  `uvm_object_utils_end

  function string convert2string();
    return $sformatf("out: %0d",out);
  endfunction :convert2string

  virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    bit result = 1;
    calculator_seq_item t;

    assert($cast(t, rhs));

    //----------------------------------------------
    // All the output signals must be compared here.

    if(out != t.out) begin
      `uvm_error ("ERROR", $sformatf("out signal is not matching! - lhs: %h, rhs: %h", out, t.out));
      result = 0;
    end

    //----------------------------------------------

    return result;
  endfunction

endclass
