class seq extends uvm_sequence #(spec_signals);
    `uvm_object_utils(seq)

    // declare message
    spec_signals mx;

    function new(string name="seq");
        super.new(name);
    endfunction

    task body();
        mx = new();
        do_rst(3);

        generate_matrices();

    endtask

    task do_rst(int num_reps);
        repeat(num_reps) begin
            start_item(mx);
            mx.i_rst_n = 0;
            finish_item(mx);
        end
    endtask

    task generate_matrices();
        start_item(mx);
        mx.i_rst_n = 1;
        mx.randomize();
        finish_item(mx);
    endtask
endclass