class calculator_agent extends uvm_agent;
    `uvm_component_utils(calculator_agent)

    typedef uvm_sequencer #(calculator_seq_item) sequencer;

    sequencer            sqr;
    calculator_driver    drv;
    calculator_monitor   mon;

    uvm_analysis_port #(calculator_seq_item) agent_port;

    function new(string name = "calculator_agent", uvm_component parent = null);
        super.new(name, parent);
        agent_port = new("agent_port", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon = calculator_monitor::type_id::create("mon", this);
        sqr = sequencer::type_id::create("sqr", this);
        drv = calculator_driver::type_id::create("drv", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon.agent_port.connect(agent_port);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass: calculator_agent