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
        scoreboard_port_in.connect(rm.in);
        scoreboard_port_out.connect(comp.before_export);
        rm.out.connect(comp.after_export);
    endfunction
endclass: calculator_scoreboard

//Port Connection
//1.If the ports are equal, it doesn't matter the order.
//2.From left to right the connection should take preference as follows:
    //2.1 Imp ports need a 'write' method that can write to them
    //2.2 Export ports are for going down to class level, e.g,
    // from scoreboard to refmod. The refmod is below the scoreboard, hierarchically.