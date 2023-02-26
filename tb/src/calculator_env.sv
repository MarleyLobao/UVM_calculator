class calculator_env extends uvm_env;
    `uvm_component_utils(calculator_env)

    calculator_coverage cv;
    calculator_scoreboard sb;
    calculator_agent ag;

    function new(string name = "calculator_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cv = calculator_coverage::type_id::create("cv", this);
        sb = calculator_scoreboard::type_id::create("sb", this);
        ag = calculator_agent::type_id::create("ag", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        ag.agent_port_in.connect(cv.analysis_export);
        ag.agent_port_in.connect(sb.scoreboard_port_in);
        ag.agent_port_out.connect(sb.scoreboard_port_out);
    endfunction
endclass: calculator_env