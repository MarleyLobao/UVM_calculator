class calculator_coverage extends uvm_subscriber #(calculator_seq_item);
    `uvm_component_utils(calculator_coverage)

    calculator_seq_item seq_item;

    event new_seq_item;

    covergroup inputs_cg();
      option.name = "Inputs Covergroup";
      option.per_instance = 1;

      dat_a_cp:coverpoint seq_item.dat_a_in{
        option.at_least = 100;
        
        bins corner_up_b   = {127};
        bins middle_pos_b  = {[1:126]};
        bins zeros_b       = {0};
        bins ones_b        = {-1};
        bins middle_neg_b  = {[-2:-127]};
        bins corner_down_b = {-128};
      }

      dat_b_cp:coverpoint seq_item.dat_b_in{
        option.at_least = 100;

        bins corner_up_b   = {127};
        bins middle_pos_b  = {[1:126]};
        bins zeros_b       = {0};
        bins ones_b        = {-1};
        bins middle_neg_b  = {[-2:-127]};
        bins corner_down_b = {-128};
      }

      function_cp:coverpoint seq_item.function_in{
        option.at_least = 200;

        bins sum_b = {'b00};
        bins sub_b = {'b01};
        bins mul_b = {'b10};
        bins div_b = {'b11};
      }

      cross_data: cross dat_a_cp, dat_b_cp, function_cp;
    endgroup

    function new(string name="calculator_coverage", uvm_component parent);
      super.new(name, parent);
      inputs_cg = new();
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      seq_item = calculator_seq_item::type_id::create("seq_item", this);
    endfunction

    task main_phase(uvm_phase phase);
      forever inputs_sample();
    endtask

    task inputs_sample();
      @(new_seq_item);
      inputs_cg.sample();
    endtask

    virtual function void write(calculator_seq_item t);
      seq_item.copy(t);
      -> new_seq_item;
    endfunction
endclass
