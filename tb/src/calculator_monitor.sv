class calculator_monitor extends uvm_monitor;
    `uvm_component_utils(calculator_monitor)

    virtual calculator_if inter;
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
        
        if(!uvm_config_db#(virtual calculator_if)::get(this, "", "vif", inter)) begin
            `uvm_fatal("NOVIF","The virtual connection wasn't successful!");
        end

    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        wait(inter.rst_n === 0);
        
        @(posedge inter.rst_n);
        fork

            forever begin
                @(posedge inter.clk)
                seq_item_in.dat_a_in <= inter.dat_a_in;
                seq_item_in.dat_b_in <= inter.dat_b_in;
                seq_item_in.function_in <= inter.function_in;
                monitor_port_in.write(seq_item_in);
            end

            begin
                @(posedge inter.clk)

                forever begin
                    @(posedge inter.clk)
                    seq_item_out.out <= inter.out;
                    monitor_port_out.write(seq_item_out);
                end
            end
        join           


    endtask
endclass : calculator_monitor
