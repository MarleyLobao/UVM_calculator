class calculator_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(calculator_scoreboard)

    typedef uvm_in_order_class_comparator #(calculator_seq_item) comparator;
    
    calculator_refmod rm;
    comparator comp;

    uvm_analysis_export #(calculator_seq_item) scoreboard_port_in;
    uvm_analysis_export #(calculator_seq_item) scoreboard_port_out;

    function new(string name = "calculator_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        scoreboard_port_in = new("scoreboard_port_in", this);
        scoreboard_port_out = new("scoreboard_port_out", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rm = calculator_refmod::type_id::create("rm", this);
        comp = comparator::type_id::create("comp", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        //rm.in.connect(scoreboard_port_in);
        scoreboard_port_in.connect(rm.in);
        scoreboard_port_out.connect(comp.before_export);
        rm.out.connect(comp.after_export);
    endfunction
endclass: calculator_scoreboard
