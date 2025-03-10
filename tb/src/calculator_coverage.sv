class calculator_coverage extends uvm_subscriber #(calculator_seq_item);
    `uvm_component_utils(calculator_coverage)

    calculator_seq_item seq_item;

    event new_seq_item;

    covergroup operation_cg;
      option.name = "Operations Covergroup";
      option.per_instance = 1;

      function_cp:coverpoint seq_item.function_in{
        option.at_least = 200;

        bins sum_b = {'b00};
        bins sub_b = {'b01};
        bins mul_b = {'b10};
        bins div_b = {'b11};
      }

      op_seq_cp:coverpoint seq_item.function_in{
        option.at_least = 20;

        bins single_mul[] = ([2'b00:2'b11] => 2'b10);
        bins mul_single[] = (2'b10 => [2'b00:2'b11]);

        bins two_ops[] = ([2'b00:2'b11] [* 2]);
        bins many_mul  = (2'b10 [* 3:5]);
      }
    endgroup

    covergroup inputs_cg();
      option.name = "Inputs Covergroup";
      option.per_instance = 1;

      dat_a_cp:coverpoint seq_item.dat_a_in{
        option.at_least = 100;
        
        bins corner_up_b   = {8'sd127};
        bins zeros_b       = {8'sd0};
        bins ones_b        = {-8'sd1};
        bins corner_down_b = {-8'sd128};
        bins others_b      = {[8'sd1:8'sd126],[-8'sd2:-8'sd127]};
      }

      dat_b_cp:coverpoint seq_item.dat_b_in{
        option.at_least = 100;

        bins corner_up_b   = {8'sd127};
        bins zeros_b       = {8'sd0};
        bins ones_b        = {-8'sd1};
        bins corner_down_b = {-8'sd128};
        bins others_b      = {[8'sd1:8'sd126],[-8'sd2:-8'sd127]};
      }

      data_cross:  cross dat_a_cp, dat_b_cp, operation_cg.function_cp {
        ignore_bins except_A_others = binsof(dat_a_cp.others_b);
        ignore_bins except_B_others = binsof(dat_b_cp.others_b);
      }
    endgroup

    function new(string name="calculator_coverage", uvm_component parent);
      super.new(name, parent);
      operation_cg = new();
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
      operation_cg.sample();
      inputs_cg.sample();
    endtask

    virtual function void write(calculator_seq_item t);
      seq_item.copy(t);
      -> new_seq_item;
    endfunction
endclass
