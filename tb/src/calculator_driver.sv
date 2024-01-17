class calculator_driver extends uvm_driver #(calculator_seq_item);
    `uvm_component_utils(calculator_driver)

    virtual calculator_if vif_driver;
    calculator_seq_item seq_item;

    function new(string name = "calculator_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        if(!uvm_config_db#(virtual calculator_if)::get(this, "", "vif", vif_driver)) begin
            `uvm_fatal("NOVIF","The virtual connection wasn't successful!");
        end
    endfunction

    virtual task reset_phase(uvm_phase phase);
        phase.raise_objection(this);
        wait(vif_driver.rst_n === 0);
        vif_driver.dat_a_in    <= '0;
        vif_driver.dat_b_in    <= '0;
        vif_driver.function_in <= '0;
        @(posedge vif_driver.rst_n);
        phase.drop_objection(this);
    endtask

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);

        forever begin
            seq_item_port.get_next_item(seq_item);
            begin_tr(seq_item, "sequence_item_driver");
            @(posedge vif_driver.clk);
            vif_driver.dat_a_in    <= seq_item.dat_a_in;
            vif_driver.dat_b_in    <= seq_item.dat_b_in;
            vif_driver.function_in <= seq_item.function_in; 
            end_tr(seq_item);
            seq_item_port.item_done();
        end
    endtask
endclass : calculator_driver
