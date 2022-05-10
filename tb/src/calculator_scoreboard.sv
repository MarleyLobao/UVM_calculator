class calculator_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(calculator_scoreboard)

    typedef uvm_in_order_class_comparator #(calculator_seq_item) comparator;
    
    calculator_refmod rm;
    comparator comp;

    uvm_analysis_export #(calculator_seq_item) scoreboard_port_in;
    uvm_analysis_export #(calculator_seq_item) scoreboard_port_out;

    function new(string name = "calculator_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        scoreboard_port_in = new("scoreboard_port_in", this);
        scoreboard_port_out = new("scoreboard_port_out", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rm = calculator_refmod::type_id::create("rm", this);
        comp = comparator::type_id::create("comp", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        scoreboard_port_in.connect(rm.in);
        scoreboard_port_out.connect(comp.before_export);
        rm.out.connect(comp.after_export);
    endfunction
endclass: calculator_scoreboard

//Conexão das portas
//1.Se as portas forem iguais, não importa a ordem.
//2.Da esquerda para a direita a conexão deve ter preferência da seguinte forma:
    //2.1 Portas imp precisam de um método 'write' que possa escrever nelas
    //2.2 Portas export são para descer em nível de classe, por exemplo,
    //do scoreboard para o refmod. O refmod está abaixo do scoreboard, hierarquicamente.