class calculator_comparator extends uvm_component;
  `uvm_component_utils(calculator_comparator)
  
  int PASS_CNT, ERROR_CNT;

  calculator_seq_item calculated_seq_item;
  calculator_seq_item expected_seq_item;

  uvm_tlm_analysis_fifo #(calculator_seq_item) outfifo;
  uvm_tlm_analysis_fifo #(calculator_seq_item) expfifo;

  function new(string name="calculator_comparator", uvm_component parent);
    super.new(name, parent);
    outfifo = new("outfifo", this);
    expfifo = new("expfifo", this);

    PASS_CNT = 0;
    ERROR_CNT = 0;
  endfunction
    
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    calculated_seq_item = calculator_seq_item::type_id::create("calculated_seq_item", this);
    expected_seq_item = calculator_seq_item::type_id::create("expected_seq_item", this);
  endfunction
  
  task main_phase(uvm_phase phase);
    forever begin
      outfifo.get(calculated_seq_item);
      expfifo.get(expected_seq_item);

      `uvm_info ("[COMPARATION]",$sformatf("block: %d - model: %d",calculated_seq_item.out,expected_seq_item.out), UVM_DEBUG);

      if (calculated_seq_item.out == expected_seq_item.out) PASS();
      else ERROR();
    end
  endtask: main_phase

  function void report_phase(uvm_phase phase);
    phase.raise_objection(this);
    if(!ERROR_CNT) begin
      `uvm_info ("TEST PASS",$sformatf("TEST WAS FINALIZED WITH %4d HITS!",PASS_CNT), UVM_LOW);
    end else begin
      `uvm_info ("TEST FAIL",$sformatf("TEST WAS FINALIZED WITH %4d ERRORS!",ERROR_CNT), UVM_LOW);
    end
    phase.drop_objection(this);
  endfunction: report_phase

  function void PASS();
    PASS_CNT++;
    `uvm_info ("PASS",calculated_seq_item.convert2string(), UVM_HIGH);
  endfunction

  function void ERROR();
    ERROR_CNT++;
    `uvm_error ("ERROR [CALCULATED]",calculated_seq_item.convert2string());
    `uvm_info ("ERROR [EXPECTED]",expected_seq_item.convert2string(), UVM_LOW);
  endfunction

endclass
