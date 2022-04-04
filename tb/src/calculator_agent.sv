class calculator_agent extends uvm_agent;
    `uvm_component_utils(calculator_agent)

    typedef uvm_sequencer #(calculator_seq_item) sequencer;

    sequencer            sqr;
    calculator_driver    drv;
    calculator_monitor   mon;

    uvm_analysis_port #(calculator_seq_item) agent_port_in;
    uvm_analysis_port #(calculator_seq_item) agent_port_out;

    function new(string name = "calculator_agent", uvm_component parent = null);
        super.new(name, parent);
        agent_port_in = new("agent_port_in", this);
        agent_port_out = new("agent_port_out", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon = calculator_monitor::type_id::create("mon", this);
        sqr = sequencer::type_id::create("sqr", this);
        drv = calculator_driver::type_id::create("drv", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        mon.monitor_port_in.connect(agent_port_in);
        mon.monitor_port_out.connect(agent_port_out);
        drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
endclass: calculator_agent