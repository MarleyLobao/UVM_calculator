class calculator_test extends uvm_test;
  `uvm_component_utils(calculator_test)

  int CYCLES,LATENCY_BLOCK;

  calculator_env envir;
  calculator_sequence seq;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);

    CYCLES = 1000;
    LATENCY_BLOCK = 2;
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    envir = calculator_env::type_id::create("envir", this);
    seq = calculator_sequence::type_id::create("seq", this);
  endfunction
 
  task main_phase(uvm_phase phase);    
    phase.raise_objection(this);

    fork
      seq.start(envir.ag.sqr);
      repeat(CYCLES) @(posedge envir.ag.drv.inter.clk);
    join_any
    
    repeat(LATENCY_BLOCK) @(posedge envir.ag.drv.inter.clk);

    phase.drop_objection(this);
  endtask: main_phase
endclass
