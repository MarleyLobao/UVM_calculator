class calculator_test extends uvm_test;
  `uvm_component_utils(calculator_test)

  int CYCLES;

  calculator_env envir;
  calculator_sequence seq;

  function new(string name, uvm_component parent = null);
    super.new(name, parent);

    if($value$plusargs("CYCLES=%d", CYCLES)) begin
      `uvm_info("SIM_CYCLES", $sformatf("It will run %d cycles.", CYCLES), UVM_LOW);
    end else CYCLES = 1000;
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
      wait_for_clk_cycles(CYCLES);
    join_any
    
    // Waiting for remaining outputs
    seq.kill();
    wait_for_clk_cycles(LATENCY_BLOCK+1);

    phase.drop_objection(this);
  endtask: main_phase

  task wait_for_clk_cycles(int clk_cycles);
    repeat(clk_cycles) @(posedge envir.ag.drv.vif_driver.clk);
  endtask : wait_for_clk_cycles
endclass
