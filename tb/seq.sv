class seq extends uvm_sequence #(drvr_in);
    `uvm_object_utils(seq)

    // declare message
    drvr_in mx;

    function new(string name="seq");
        super.new(name);
    endfunction

    task body();
        mx = new();
        do_rst(3);

        start_item(mx);
        generate_matrices();
        finish_item(mx);

    endtask

    task do_rst(int num_reps);
        repeat(num_reps) begin
            start_item(mx);
            mx.i_rst_n = 0;
            finish_item(mx);
        end
    endtask

    task generate_matrices();
        mx.i_rst_n = 1;
        foreach (mx.A_mat[i]) begin
            mx.A_mat[i] = $random();
            mx.B_mat[i] = $random();
        end
    endtask
endclass