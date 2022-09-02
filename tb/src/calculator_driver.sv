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

    virtual task main_phase(uvm_phase phase);
        super.main_phase(phase);
        
        wait(vif_driver.rst_n === 0);

        forever begin
            @(posedge vif_driver.clk);
                        
            if (!vif_driver.rst_n) begin
                vif_driver.dat_a_in <= 8'd0;
                vif_driver.dat_b_in <= 8'd0;
                vif_driver.function_in <= 2'd0;
            end else begin
                seq_item_port.try_next_item(seq_item);
                vif_driver.dat_a_in <= seq_item.dat_a_in;
                vif_driver.dat_b_in <= seq_item.dat_b_in;
                vif_driver.function_in <= seq_item.function_in;
                seq_item_port.item_done();
            end
        end
    endtask
endclass : calculator_driver
