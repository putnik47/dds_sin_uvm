class dds_sin_seqc_default extends uvm_sequence #(dds_sin_seqi); // [UVM] class
    `uvm_object_utils(dds_sin_seqc_default);                 // [UVM] macro

    function new(string name = "dds_sin_seqc_default");
        super.new(name);
    endfunction : new

    task body();
        dds_sin_seqi tx;
        tx = dds_sin_seqi::type_id::create("tx");
        repeat(100) begin
            start_item(tx);                          // [UVM] start transaction
                assert(tx.randomize());
            finish_item(tx);                         // [UVM] finish transaction
        end
    endtask : body
    
endclass

