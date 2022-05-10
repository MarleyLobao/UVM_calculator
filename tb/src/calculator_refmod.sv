import "DPI-C" context function int calc(int data_a, int data_b, int func);

class calculator_refmod extends uvm_component;
    `uvm_component_utils(calculator_refmod)
    
    calculator_seq_item csi_in;
    calculator_seq_item csi_out;

    event start_calc;
    
    uvm_analysis_imp #(calculator_seq_item, calculator_refmod) in;
    uvm_analysis_port #(calculator_seq_item) out;
    
    function new(string name = "calculator_refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        csi_in = calculator_seq_item::type_id::create("csi_in", this);
        csi_out = calculator_seq_item::type_id::create("csi_out", this);
    endfunction: build_phase

    task write(calculator_seq_item t);
        csi_in.copy(t);
        -> start_calc;
    endtask
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            @(start_calc);
            csi_out.out = calc(csi_in.dat_a_in, csi_in.dat_b_in, csi_in.function_in);
            out.write(csi_out);
        end
    endtask: run_phase
endclass: calculator_refmod
