class dds_sin_test_default extends uvm_test;                 // [UVM] class
    `uvm_component_utils(dds_sin_test_default)               // [UVM] macro

    extern function new(string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);      // [UVM] build phase
    extern task run_phase(uvm_phase phase);                 // [UVM] run phase

    virtual dds_sin_if dut_vi;                          // virtual handler

    dds_sin_agnt                     dds_sin_agnt_h;
    dds_sin_seqc_default             dds_sin_seqc_default_h;
endclass

//-------------------------------------------------------------------------------------------------------------------------------
// IMPLEMENTATION
//-------------------------------------------------------------------------------------------------------------------------------
function dds_sin_test_default::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void dds_sin_test_default::build_phase(uvm_phase phase);
    // get bfm from database
    if (!uvm_config_db #(virtual dds_sin_if)::get(           // [UVM] try to get interface
        this, "", "dut_vi", dut_vi)               // from uvm database
    ) `uvm_fatal("BFM", "Failed to get bfm");               // otherwise throw error

    dds_sin_agnt_h = dds_sin_agnt::type_id::create("dds_sin_agnt_h", this);
    dds_sin_agnt_h.dut_vi = this.dut_vi;

    dds_sin_seqc_default_h = dds_sin_seqc_default::type_id::create("dds_sin_seqc_default_h", this);
endfunction

task dds_sin_test_default::run_phase(uvm_phase phase);
    phase.raise_objection(this);                            // [UVM] start sequence
        dds_sin_seqc_default_h.start(dds_sin_agnt_h.dds_sin_seqr_h);
    phase.drop_objection(this);                             // [UVM] finish sequence
endtask