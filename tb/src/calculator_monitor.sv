class calculator_monitor extends uvm_monitor;
    `uvm_component_utils(calculator_monitor)

    virtual calculator_if vif_monitor;
    calculator_seq_item seq_item_in, seq_item_out;

    uvm_analysis_port #(calculator_seq_item) monitor_port_in;
    uvm_analysis_port #(calculator_seq_item) monitor_port_out;

    function new(string name = "calculator_monitor", uvm_component parent = null);
        super.new(name, parent);
        monitor_port_in = new("monitor_port_in",this);
        monitor_port_out = new("monitor_port_out",this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq_item_in = calculator_seq_item::type_id::create("seq_item_in",this);
        seq_item_out = calculator_seq_item::type_id::create("seq_item_out",this);
        
        if(!uvm_config_db#(virtual calculator_if)::get(this, "", "vif", vif_monitor)) begin
            `uvm_fatal("NOVIF","The virtual connection wasn't successful!");
        end
    endfunction

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        
        fork
            begin
                forever begin
                    begin_tr(seq_item_in, "seq_item_monitor_in");
                    @(posedge vif_monitor.clk);
                    seq_item_in.dat_a_in    <= vif_monitor.dat_a_in;
                    seq_item_in.dat_b_in    <= vif_monitor.dat_b_in;
                    seq_item_in.function_in <= vif_monitor.function_in;
                    end_tr(seq_item_in);
                    monitor_port_in.write(seq_item_in);
                end
            end

            begin
                forever begin
                    begin_tr(seq_item_out, "seq_item_monitor_out");
                    @(posedge vif_monitor.clk);
                    seq_item_out.out <= vif_monitor.out;
                    end_tr(seq_item_out);
                    monitor_port_out.write(seq_item_out);
                end
            end
        join
    endtask
endclass : calculator_monitor
