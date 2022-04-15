class calculator_driver extends uvm_driver #(calculator_seq_item);
    `uvm_component_utils(calculator_driver)

    virtual calculator_if inter;
    calculator_seq_item seq_item;

    function new(string name = "calculator_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if(!uvm_config_db#(virtual calculator_if)::get(this, "", "vif", inter)) begin
            `uvm_fatal("NOVIF","The virtual connection wasn't successful!");
        end
        
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        wait(inter.rst_n === 0);

        forever begin
                        
            if (!inter.rst_n) begin
                @(posedge inter.clk);
                inter.dat_a_in <= 8'd0;
                inter.dat_b_in <= 8'd0;
                inter.function_in <= 2'd0;
            end else begin
                seq_item_port.try_next_item(seq_item);
                @(posedge inter.clk);
                inter.dat_a_in <= seq_item.dat_a_in;
                inter.dat_b_in <= seq_item.dat_b_in;
                inter.function_in <= seq_item.function_in;
                seq_item_port.item_done();
            end

        end
    endtask
endclass : calculator_driver
