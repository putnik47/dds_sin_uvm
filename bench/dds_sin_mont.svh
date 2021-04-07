class dds_sin_mont extends uvm_monitor;                      // [UVM] class
    `uvm_component_utils(dds_sin_mont);                      // [UVM] macro - //вызов конструктора

    extern function new(string name, uvm_component parent);     // вызов конструктора
    extern function void build_phase(uvm_phase phase);      // [UVM] build freq_i
    extern task run_phase(uvm_phase phase);                 // [UVM] run freq_i

    virtual dds_sin_if               dut_vi;           // our interface

    dds_sin_aprt                     dds_sin_aprt;          // analysis port, input
    dds_sin_seqi                     tx;          // transaction, input/output
endclass

//-------------------------------------------------------------------------------------------------------------------------------
// IMPLEMENTATION
//-------------------------------------------------------------------------------------------------------------------------------
function dds_sin_mont::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void dds_sin_mont::build_phase(uvm_phase phase);
    // build analysis ports
    dds_sin_aprt = new("dds_sin_aprt", this);
endfunction

task dds_sin_mont::run_phase(uvm_phase phase);
    forever begin 
        @(negedge dut_vi.iclk) begin
                tx = dds_sin_seqi::type_id::create("tx");
                tx.freq_i = dut_vi.freq_i;
                tx.freq_we = dut_vi.freq_we;
                tx.sin_v = dut_vi.sin_v;
                dds_sin_aprt.write(tx);            
            end
    end
endtask