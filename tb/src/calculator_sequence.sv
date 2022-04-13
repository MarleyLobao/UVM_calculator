class calculator_sequence extends uvm_sequence #(calculator_seq_item);
    `uvm_object_utils(calculator_sequence)

    function new(string name="calculator_sequence");
        super.new(name);
    endfunction: new

    task body;
        calculator_seq_item tx;

        forever begin
            tx = calculator_seq_item::type_id::create("tx");
            start_item(tx);
            assert(tx.randomize());
            finish_item(tx);
        end
    endtask: body
endclass: calculator_sequence