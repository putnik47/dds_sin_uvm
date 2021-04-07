typedef enum
{
    BUS_WRITE,
    BUS_IDLE
}bus_op_t;

class dds_sin_seqi extends uvm_sequence_item;                // [UVM] class
    /*-------------------------------------------------------------------------------
    -- UVM Factory register
    -------------------------------------------------------------------------------*/
    // Provide implementations of virtual methods such as get_type_name and create
    `uvm_object_utils(dds_sin_seqi);                         // [UVM] macro

    extern function new(string name = "dds_sin_seqi");

    rand int freq_we;
    rand int freq_i;
    rand bus_op_t bus_op;
    int sin_v;
    int sin_o;

    constraint c_freq_we { freq_we inside {[0:1]};}
    constraint c_bus_op { bus_op inside {BUS_WRITE,BUS_IDLE}; }
    constraint c_freq {
        freq_i inside{[10_000_00:50_000_00]};
    }
    extern function string convert2string();
endclass

//----------------------------------------------------------------------------------
// IMPLEMENTATION
//----------------------------------------------------------------------------------
function dds_sin_seqi::new(string name = "dds_sin_seqi");
    super.new(name);
endfunction

function string dds_sin_seqi::convert2string();
    string s;
    s = $sformatf("freq_i = %d; sin_o = %d", freq_i, sin_o);
    return s;
endfunction
