class calculator_test extends uvm_test;
  `uvm_component_utils(calculator_test)

  int CYCLES;

  calculator_env envir;
  calculator_sequence seq;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);
    CYCLES = 1000;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    envir = calculator_env::type_id::create("envir", this);
    seq = calculator_sequence::type_id::create("seq", this);
  endfunction
 
  task run_phase(uvm_phase phase);
    seq.start(envir.ag.sqr);
    phase.raise_objection(this);

    repeat(CYCLES) @(envir.ag.mon.inter.clk);

    phase.drop_objection(this);
  endtask: run_phase

endclass
