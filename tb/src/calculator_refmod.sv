import "DPI-C" context function int calc(int data_a, int data_b, int func);

class calculator_refmod extends uvm_component;
    `uvm_component_utils(calculator_refmod)

    virtual calculator_if vif_refmod;
    
    calculator_seq_item csi_in;
    calculator_seq_item csi_out;

    event start_calc;

    int reset_latency;
    
    uvm_analysis_imp #(calculator_seq_item, calculator_refmod) in;
    uvm_analysis_port #(calculator_seq_item) out;
    
    function new(string name = "calculator_refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);

        reset_latency = 0;
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        csi_in = calculator_seq_item::type_id::create("csi_in", this);
        csi_out = calculator_seq_item::type_id::create("csi_out", this);

        if(!uvm_config_db#(virtual calculator_if)::get(this, "", "vif", vif_refmod)) begin
            `uvm_fatal("NOVIF","The virtual connection wasn't successful!");
        end
    endfunction: build_phase

    task write(calculator_seq_item t);
        csi_in.copy(t);
        -> start_calc;
    endtask
    
    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        
        forever begin
            @(start_calc);
            begin_tr(csi_out,"refmod");

            #CLK_PERIOD;
            csi_out.out <= calc(csi_in.dat_a_in, csi_in.dat_b_in, csi_in.function_in);

            if(vif_refmod.rst_n) begin
                if(reset_latency == 0) out.write(csi_out);
                else if(reset_latency > 0) reset_latency--;
                else reset_latency = 0;
            end else begin
                reset_latency = 3;
            end

            end_tr(csi_out);
        end
    endtask: main_phase
endclass: calculator_refmod
